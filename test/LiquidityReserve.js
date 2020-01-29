const {
  ether,
  BN
} = require("@openzeppelin/test-helpers");
  
const { helpers, generated } = require('chainlink');
const BigNumber = require('bignumber.js');
const EVMRevert = require('./helpers/EVMRevert').EVMRevert;
const increaseTime = require('./helpers/increaseTime');
const increaseTimeTo = increaseTime.increaseTimeTo;

const ZERO_ADDR = '0x0000000000000000000000000000000000000000';

const Oracle = artifacts.require("ChainlinkOracle");
const TokenMock = artifacts.require("TokenMock");
const AlkemiNetwork = artifacts.require("AlkemiNetwork");
const LiquidityReserve = artifacts.require("LiquidityReserve");

const encodeUint256 = (int) => {
  const zeros = '0000000000000000000000000000000000000000000000000000000000000000'
  const payload = int.toString(16)
  return (zeros + payload).slice(payload.length)
}

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();

contract('Alkemi Liquidity Reserve', ([alkemiTeam, liquidityProvider1, liquidityProvider2, liquidityProvider3, liquidityProvider4, liquidityProvider5, oracleChainlinkNode, random]) => {
  const dayTime = 24 * 3600;
  const now = Math.floor(Date.now() / 1000);
  const lockingPeriod = now + dayTime*5;
  const newLockingPeriod = lockingPeriod+5;
  const lockingPrice = ether("200");
  const lockingPricePosition = 0; // unlock funds if oracle price is below lockingPrice  
  const supplyToMint = ether("1000");

  const jobId = web3.utils.toHex('0e9e244b9c374cd1a5c714caf25b0be5')
  // Represents 1 LINK for testnet requests
  const payment = web3.utils.toWei('1', 'ether');

  let token1, token2, linkToken, oc, alkemiNetwork, liquidityReserve1;

  before(async() => {
    // ERC20 token mock for testing
    token1 = await TokenMock.new(
      "token1",
      "tk1",
      18,
      { from: alkemiTeam }
    );
    token2 = await TokenMock.new(
      "token2",
      "tk2",
      18,
      { from: alkemiTeam }
    );

    linkToken = await helpers.create(generated.LinkTokenFactory, alkemiTeam).deploy();
    oc = await Oracle.new(linkToken.address, { from: alkemiTeam })
    await oc.setFulfillmentPermission(
      oracleChainlinkNode,
      true,
      { from: alkemiTeam }
    );

    alkemiNetwork = await AlkemiNetwork.new({ from: alkemiTeam });

    // Mint tokens
    await token1.mint(liquidityProvider1, supplyToMint);
    await token1.mint(liquidityProvider2, supplyToMint);
    await token1.mint(liquidityProvider3, supplyToMint);
    await token1.mint(liquidityProvider4, supplyToMint);
    await token1.mint(liquidityProvider5, supplyToMint);
    await token1.mint(random, supplyToMint);
    await token2.mint(liquidityProvider2, supplyToMint);
  });

  describe("Liquidity Reserve", async() => {
    it("check deployment", async() => {
      assert.equal(await alkemiNetwork.owner.call(), alkemiTeam, "Wrong Alkemi Network owner");
    });
  });
  
  describe("Create liquidity reserve", async() => {
    it("create liquidity reserve", async() => {
      await alkemiNetwork.createLiquidityReserve(
        linkToken.address,
        ZERO_ADDR,
        token1.address,
        now,
        lockingPeriod,
        lockingPrice,
        lockingPricePosition,
        { from: liquidityProvider1 }
      );    
    
      let liquidityReserve1Address = await alkemiNetwork.providerLiquidityReserves.call(liquidityProvider1);
      liquidityReserve1 = await LiquidityReserve.at(liquidityReserve1Address[liquidityReserve1Address.length - 1]);   

      assert.equal(await liquidityReserve1.asset.call(), token1.address, "wrong asset address");
      assert.equal(await liquidityReserve1.lockingPeriod.call(), lockingPeriod, "wrong locking period");
      assert.equal((await alkemiNetwork.providerLiquidityReserves.call(liquidityProvider1))[0], (await alkemiNetwork.providerTokenReserves.call(liquidityProvider1, token1.address))[0]);
      assert.equal((await alkemiNetwork.providerLiquidityReserves.call(liquidityProvider1))[0], (await alkemiNetwork.tokenLiquidityReserves.call(token1.address))[0]);
      assert.equal((await alkemiNetwork.tokenLiquidityReserves.call(token1.address))[0], (await alkemiNetwork.providerTokenReserves.call(liquidityProvider1, token1.address))[0]);
    });
  });

  describe("deposit into reserve", async() => {
    const amountToDeposit = ether("400");

    it("should revert when depositing token without aprroving transfer to the liquidity contract", async() => {
      await liquidityReserve1.deposit(amountToDeposit, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
    });

    it("should revert when depositing token amount equal to zero", async() => {
      //aprove the reserve to transfer tokens
      await token1.approve(liquidityReserve1.address, amountToDeposit, {from: liquidityProvider1});

      await liquidityReserve1.deposit(ether("0"), {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
    });

    it("should revert when depositing token from address that have no permission", async() => {
      //aprove the reserve to transfer tokens
      await token1.approve(liquidityReserve1.address, amountToDeposit, {from: random});

      await liquidityReserve1.deposit(amountToDeposit, {from: random}).should.be.rejectedWith(EVMRevert);
    });  

    it("deposit", async() => {
      let reserveBalanceBefore = await liquidityReserve1.balance.call(token1.address);
      let providerBalanceBefore = await token1.balanceOf.call(liquidityProvider1);

      await liquidityReserve1.deposit(amountToDeposit, {from: liquidityProvider1});

      let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
      let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);

      assert.equal(parseInt(reserveBalanceBefore)+parseInt(amountToDeposit), reserveBalanceAfter.toString(), "Wrong reserve balance");
      assert.equal(parseInt(providerBalanceBefore)-parseInt(amountToDeposit), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
    });

    it("should revert depositing into an already deposited-in reserve", async() => {
      await token1.approve(liquidityReserve1.address, amountToDeposit, {from: random});
      await liquidityReserve1.deposit(amountToDeposit, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
    });
  });

  describe("Withdraw", async() => {
    const amountToWithdraw = ether("100");

    describe("Liquidity provider withdraw", async() => {
      it("should revert withdrawing during locking period and price locking", async() => {
        await liquidityReserve1.withdraw(amountToWithdraw, oc.address, jobId, await token1.symbol.call(), "USD", payment, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
      });
      
      
      it("withdraw when price locking condition is valid even if locking period is not valid", async() => {
        const expected = 100;
        const response = `0x${encodeUint256(expected)}`;    
        let request;
        
        // send Link token to reserve address
        await linkToken.transfer(liquidityReserve1.address, payment);
  
        let reserveBalanceBefore = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceBefore = await token1.balanceOf.call(liquidityProvider1);
       
        let _lockingPricePosition = await liquidityReserve1.lockingPricePosition.call();
        let _lockingPrice = await liquidityReserve1.lockingPrice.call();

        // withdraw
        let tx = await liquidityReserve1.withdraw(amountToWithdraw, oc.address, jobId, await token1.symbol.call(), "USD", payment, {from: liquidityProvider1});

        // fulfill tequest from oracle
        request = helpers.decodeRunRequest(tx.receipt.rawLogs[3]);
        await helpers.fulfillOracleRequest(oc, request, response, { from: oracleChainlinkNode });
        
        // fetch asset price
        let _oraclePrice = await liquidityReserve1.oraclePrice.call();
       
        if(_lockingPricePosition.toNumber() == 0) {
          assert.ok(_oraclePrice < _lockingPrice, "Oracle price is not less than locking price");
        }
        else {
          assert.ok(_oraclePrice > _lockingPrice, "Oracle price is not greater than locking price"); 
        }
                
        let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
        assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
      });

      it("withdraw when locking period is valid even if price locking is not valid", async() => {
        // increase time
        await increaseTimeTo(lockingPeriod+1);

        let reserveBalanceBefore = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceBefore = await token1.balanceOf.call(liquidityProvider1);

        await liquidityReserve1.withdraw(amountToWithdraw, oc.address, jobId, await token1.symbol.call(), "USD", payment, {from: liquidityProvider1});

        let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
        assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
      }); 
      
      it("should revert another liqudity provider withdrawing from liquidity reserve", async() => {
        await liquidityReserve1.withdraw(amountToWithdraw, oc.address, jobId, await token1.symbol.call(), "USD", payment, {from: liquidityProvider2}).should.be.rejectedWith(EVMRevert);
      });
    });  
    
    describe("Locking period", async() => {
      it("should revert extending locking period from an address other than provider", async() => {      
        await liquidityReserve1.extendLockingPeriod(lockingPeriod, { from: liquidityProvider1 }).should.be.rejectedWith(EVMRevert);
      });

      it("extend locking period", async() => {  
        await liquidityReserve1.extendLockingPeriod(newLockingPeriod, { from: liquidityProvider1 });
  
        //await liquidityReserve1.withdraw(amountToWithdraw, oc.address, jobId, await token1.symbol.call(), "USD", payment, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
        assert.equal((await liquidityReserve1.lockingPeriod.call()).toString(), newLockingPeriod, "Wrong locking period");
      });
    });
  });

  describe("Create request", () => {
    it("should revert when sending request without tokens", async () => {
      await liquidityReserve1.requestAssetPrice(oc.address, jobId, await token1.symbol.call(), "USD", payment, { from: liquidityProvider1 }).should.be.rejectedWith(EVMRevert);
    });

    it("send price request", async () => {
      let request;

      await linkToken.transfer(liquidityReserve1.address, payment);

      const tx = await liquidityReserve1.requestAssetPrice(oc.address, jobId, await token1.symbol.call(), "USD", payment, { from: liquidityProvider1 });
      request = helpers.decodeRunRequest(tx.receipt.rawLogs[3]);
      assert.equal(oc.address, tx.receipt.rawLogs[3].address);
      assert.equal(
        request.topic,
        web3.utils.keccak256('OracleRequest(bytes32,address,bytes32,uint256,address,bytes4,uint256,uint256,bytes)')
      );
    });
  });

  describe("fulfill", () => {
    const expected = 50000;
    const response = `0x${encodeUint256(expected)}`;
    let request;

    beforeEach(async () => {
      await linkToken.transfer(liquidityReserve1.address, payment);
      const tx = await liquidityReserve1.requestAssetPrice(oc.address, jobId, await token1.symbol.call(), "USD", payment, { from: liquidityProvider1 });
      request = helpers.decodeRunRequest(tx.receipt.rawLogs[3]);
      await helpers.fulfillOracleRequest(oc, request, response, { from: oracleChainlinkNode });
    })

    it("records the data given to it by the oracle", async () => {
      const currentPrice = await liquidityReserve1.oraclePrice.call();
      assert.isTrue(new BN(currentPrice).eq(new BN(expected)));
    });

    it("should revert when node does not recognize request ID", async () => {
      const otherId = web3.utils.toHex('otherId');
      request.id = otherId;

      await helpers.fulfillOracleRequest(oc, request, response, { from: oracleChainlinkNode }).should.be.rejectedWith(EVMRevert);
    });

    it("should revert when called by anyone other than the oracle contract", async () => {
      await liquidityReserve1.fulfill(request.id, response, { from: random }).should.be.rejectedWith(EVMRevert);
    });
  });

  describe("Withdraw LINK token", () => {
    beforeEach(async () => {
      await linkToken.transfer(liquidityReserve1.address, web3.utils.toWei('1', 'ether'))
    })

    it("should revert when called by a non-owner", async () => {
      await liquidityReserve1.withdrawLink({ from: random }).should.be.rejectedWith(EVMRevert);
    });

    it("transfers LINK to the owner", async () => {
      const beforeBalance = await linkToken.balanceOf(liquidityProvider1);
      assert.equal(beforeBalance, '0');
      await liquidityReserve1.withdrawLink({ from: liquidityProvider1 });
      const afterBalance = await linkToken.balanceOf(liquidityProvider1);
      assert.equal(afterBalance.toString(), web3.utils.toWei('2', 'ether'));
    });
  });
});