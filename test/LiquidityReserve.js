const {
  ether
} = require("@openzeppelin/test-helpers");
  
const BigNumber = require('bignumber.js');
const EVMRevert = require('./helpers/EVMRevert').EVMRevert;
const increaseTime = require('./helpers/increaseTime');
const increaseTimeTo = increaseTime.increaseTimeTo;

const ZERO_ADDR = '0x0000000000000000000000000000000000000000';

const TokenMock = artifacts.require("TokenMock");
const AlkemiSettlementMock = artifacts.require("AlkemiSettlementMock");
const AlkemiNetwork = artifacts.require("AlkemiNetwork");
const LiquidityReserve = artifacts.require("LiquidityReserve");

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();

contract('Alkemi Liquidity Reserve', ([alkemiTeam, liquidityProvider1, liquidityProvider2, liquidityProvider3, liquidityProvider4, liquidityProvider5, random]) => {
  const dayTime = 24 * 3600;
  const now = Math.floor(Date.now() / 1000);
  const lockingPeriod = now + dayTime*5;
  const newLockingPeriod = lockingPeriod+5;
  const lockingPrice = 200;
  const lockingPricePosition = 0; // unlock funds if oracle price is below lockingPrice  
  const supplyToMint = ether("1000");

  let token1, token2, alkemiNetwork, liquidityReserve1;
  let alkemiSettlement;

  before(async() => {
    // ERC20 token mock for testing
    token1 = await TokenMock.new({
      from: alkemiTeam
    });
    token2 = await TokenMock.new({
      from: alkemiTeam
    });

    alkemiSettlement = await AlkemiSettlementMock.new({
      from: alkemiTeam
    });
    
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
        ZERO_ADDR,
        token1.address,
        lockingPeriod,
        lockingPrice,
        lockingPricePosition,
        { from: liquidityProvider1 }
      );    
    
      let liquidityReserve1Address = await alkemiNetwork.providerLiquidityReserves.call(liquidityProvider1);
      liquidityReserve1 = await LiquidityReserve.at(liquidityReserve1Address[liquidityReserve1Address.length - 1]);   

      assert.equal(await liquidityReserve1.asset.call(), token1.address, "wrong asset address");
      assert.equal(await liquidityReserve1.lockingPeriod.call(), lockingPeriod, "wrong locking period");
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
        await liquidityReserve1.withdraw(amountToWithdraw, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
      });
      
      /*
       *it("withdraw when price locking condition is valid even if locking period is not valid", async() => {
       *let reserveBalanceBefore = await liquidityReserve1.balance.call(token1.address);
       *let providerBalanceBefore = await token1.balanceOf.call(liquidityProvider1);
       *
       *let _lockingPricePosition = await liquidityReserve1.lockingPricePosition.call();
       *let _lockingPrice = await liquidityReserve1.lockingPrice.call();
       *let _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);
       *
       *if(_lockingPricePosition.toNumber() == 0) {
       *  await alkemiSettlement.decerementPriceOf(token1.address, 10);
       *  _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);
       *  assert.ok(_oraclePrice < _lockingPrice, "Oracle price is not less than locking price");
       *}
       *else {
       *  await alkemiSettlement.incerementPriceOf(token1.address, 10);
       *  _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);
       *  assert.ok(_oraclePrice > _lockingPrice, "Oracle price is not greater than locking price"); 
       *}
       *
       *await liquidityReserve1.withdraw(amountToWithdraw, {from: liquidityProvider1});
       *
       *let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
       *let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
       *assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
       *assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
       *});
       */

      it("withdraw when locking period is valid even if price locking is not valid", async() => {
        //reset oracle price
        await alkemiSettlement.resetPriceOf(token1.address, 200);
        // increase time
        await increaseTimeTo(lockingPeriod+1);

        let reserveBalanceBefore = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceBefore = await token1.balanceOf.call(liquidityProvider1);

        let _lockingPricePosition = await liquidityReserve1.lockingPricePosition.call();
        let _lockingPrice = await liquidityReserve1.lockingPrice.call();
        let _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);

        if(_lockingPricePosition.toNumber() == 0) {
          await alkemiSettlement.incerementPriceOf(token1.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);
          assert.ok(_oraclePrice > _lockingPrice, "Oracle price is not greater than locking price");
        }
        else {
          await alkemiSettlement.decerementPriceOf(token1.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);
          assert.ok(_oraclePrice < _lockingPrice, "Oracle price is not less than locking price"); 
        }

        await liquidityReserve1.withdraw(amountToWithdraw, {from: liquidityProvider1});

        let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
        assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
      }); 
      
      it("withdraw when both locking period and price locking are valid ", async() => {
        //reset oracle price
        await alkemiSettlement.resetPriceOf(token1.address, 200);

        let reserveBalanceBefore = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceBefore = await token1.balanceOf.call(liquidityProvider1);

        let _lockingPricePosition = await liquidityReserve1.lockingPricePosition.call();
        let _lockingPrice = await liquidityReserve1.lockingPrice.call();
        let _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);

        if(_lockingPricePosition.toNumber() == 0) {
          await alkemiSettlement.decerementPriceOf(token1.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);
          assert.ok(_oraclePrice < _lockingPrice, "Oracle price is not less than locking price");
        }
        else {
          await alkemiSettlement.incerementPriceOf(token1.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf.call(token1.address);
          assert.ok(_oraclePrice > _lockingPrice, "Oracle price is not greater than locking price"); 
        }

        await liquidityReserve1.withdraw(amountToWithdraw, {from: liquidityProvider1});

        let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
        assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
      }); 

      it("should revert another liqudity provider withdrawing from liquidity reserve", async() => {
        await liquidityReserve1.withdraw(amountToWithdraw, {from: liquidityProvider2}).should.be.rejectedWith(EVMRevert);
      });
    });    

    describe("Locking period", async() => {
      it("should revert extending locking period from an address other than provider", async() => {
        //reset oracle price
        await alkemiSettlement.resetPriceOf(token1.address, 200);
        
        await liquidityReserve1.extendLockingPeriod(lockingPeriod, { from: liquidityProvider1 }).should.be.rejectedWith(EVMRevert);
      })
      it("extend locking period", async() => {
        //reset oracle price
        await alkemiSettlement.resetPriceOf(token1.address, 200);

        await liquidityReserve1.extendLockingPeriod(newLockingPeriod, { from: liquidityProvider1 });

        await liquidityReserve1.withdraw(amountToWithdraw, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
      })
    });
  });

});