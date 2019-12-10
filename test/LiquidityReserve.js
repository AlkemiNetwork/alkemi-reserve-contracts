const {
  ether
} = require("@openzeppelin/test-helpers");
  
const BigNumber = require('bignumber.js');
const EVMRevert = require('./helpers/EVMRevert').EVMRevert;
const increaseTime = require('./helpers/increaseTime');
const increaseTimeTo = increaseTime.increaseTimeTo;

const ZERO_ADDR = '0x0000000000000000000000000000000000000000';

const TokenMock = artifacts.require("Token");
const AlkemiSettlement = artifacts.require("AlkemiSettlement");
const LiquidityReserveManager = artifacts.require("LiquidityReserveManager");
const LiquidityReserve = artifacts.require("LiquidityReserve");

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();

contract('Alkemi Liquidity Reserve', ([alkemiTeam, liquidityProvider1, liquidityProvider2, liquidityProvider3, liquidityProvider4, liquidityProvider5, random]) => {
  const dayTime = 24 * 3600;
  const now = Math.floor(Date.now() / 1000);
  const lockingPeriod = now + dayTime*2;
  const lockingPrice = 200;
  const lockingPricePosition = 0; // unlock funds if oracle price is below lockingPrice  
  const supplyToMint = ether("500");

  let token1, token2, alkemiSettlement, liquidityReserveManager, liquidityReserve1, liquidityReserve2;

  before(async() => {
    // ERC20 token mock for testing
    token1 = await TokenMock.new({
      from: alkemiTeam
    });
    token2 = await TokenMock.new({
      from: alkemiTeam
    });

    alkemiSettlement = await AlkemiSettlement.new({
      from: alkemiTeam
    });
    
    liquidityReserveManager = await LiquidityReserveManager.new({
      from: alkemiTeam
    });
       
    await liquidityReserveManager.createLiquidityReserve(
      alkemiSettlement.address,
      ZERO_ADDR,
      lockingPeriod,
      lockingPrice,
      lockingPricePosition,
      { from: liquidityProvider1 }
    );

    await liquidityReserveManager.createLiquidityReserve(
      alkemiSettlement.address,
      ZERO_ADDR,
      lockingPeriod,
      lockingPrice,
      lockingPricePosition,
      { from: liquidityProvider2 }
    );

    let liquidityReserve1Address = await liquidityReserveManager.liquidityReserveOf.call(liquidityProvider1);
    liquidityReserve1 = await LiquidityReserve.at(liquidityReserve1Address);  
    
    let liquidityReserve2Address = await liquidityReserveManager.liquidityReserveOf.call(liquidityProvider2);
    liquidityReserve2 = await LiquidityReserve.at(liquidityReserve2Address);    
    
    // Mint tokens
    await token1.mint(alkemiSettlement.address, supplyToMint);
    await token1.mint(liquidityProvider1, supplyToMint);
    await token1.mint(liquidityProvider2, supplyToMint);
    await token1.mint(liquidityProvider3, supplyToMint);
    await token1.mint(liquidityProvider4, supplyToMint);
    await token1.mint(liquidityProvider5, supplyToMint);
    await token1.mint(random, supplyToMint);
    await token2.mint(alkemiSettlement.address, supplyToMint);
    await token2.mint(liquidityProvider2, supplyToMint);
  });

  describe("Liquidity Reserve", async() => {
    it("check deployment", async() => {
      let _liquidityReserveProvider = await liquidityReserve1.liquidityProvider.call();
      let _liquidityReserveManager = await liquidityReserve1.liquidityReserveManager.call();
      let _liquidityReserveSettlementContract = await liquidityReserve1.settlementContract.call();
      assert.equal(_liquidityReserveProvider, liquidityProvider1, "Wrong liquidity reserve owner");
      assert.equal(_liquidityReserveManager, liquidityReserveManager.address, "Wrong liqudity reserve manager address");
      assert.equal(_liquidityReserveSettlementContract, alkemiSettlement.address, "Wrong settlement contract address for the liquidity reserve");
    });
  });
  
  describe("Deposit", async() => {
    const amountToDeposit = ether("400");

    it("should revert when depositing token without aprroving transfer to the liquidity contract", async() => {
      await liquidityReserve1.deposit(token1.address, amountToDeposit, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
    });

    it("should revert when depositing token from address that have no permission", async() => {
      //aprove the reserve to transfer tokens
      await token1.approve(liquidityReserve1.address, amountToDeposit, {from: random});

      await liquidityReserve1.deposit(token1.address, amountToDeposit, {from: random}).should.be.rejectedWith(EVMRevert);
    });

    it("should revert when depositing token amount equal to zero", async() => {
      //aprove the reserve to transfer tokens
      await token1.approve(liquidityReserve1.address, amountToDeposit, {from: liquidityProvider1});

      await liquidityReserve1.deposit(token1.address, ether("0"), {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
    });
    
    it("provider deposit tokens into liquidity reserve", async() => {
      //aprove the reserve to transfer tokens
      await token1.approve(liquidityReserve1.address, amountToDeposit, {from: liquidityProvider1});

      let providerBalanceBefore = await token1.balanceOf.call(liquidityProvider1);

      //deposit tokens
      await liquidityReserve1.deposit(token1.address, amountToDeposit, {from: liquidityProvider1});
      
      let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
      let reserveBalance = await liquidityReserve1.balance.call(token1.address);

      assert.equal(providerBalanceBefore-providerBalanceAfter, amountToDeposit, "Wrong deposited amount");
      assert.equal(reserveBalance.toString(), amountToDeposit.toString(), "Wrong reserve balance");
    });

    it("settlement contract deposit tokens into liquidity reserve", async() => {
      //aprove the reserve to transfer tokens
      await alkemiSettlement.approveTokenTransfer(liquidityReserve1.address, token1.address, amountToDeposit, {from: alkemiTeam});

      let alkemiSettlementBalanceBefore = await token1.balanceOf.call(alkemiSettlement.address);
      let reserveBalanceBefore = await liquidityReserve1.balance.call(token1.address);

      //deposit tokens
      await alkemiSettlement.depositIntoLiquidityReserve(liquidityReserve1.address, token1.address, amountToDeposit, {from: alkemiTeam});
      
      let alkemiSettlementBalanceAfter = await token1.balanceOf.call(alkemiSettlement.address);
      let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);

      assert.equal(alkemiSettlementBalanceBefore-alkemiSettlementBalanceAfter, amountToDeposit, "Wrong deposited amount");
      assert.equal(reserveBalanceAfter.toString(), parseInt(reserveBalanceBefore)+parseInt(amountToDeposit), "Wrong reserve balance");
    });    

    it("provider deposit multiple tokens into liquidity reserve", async() => {
      //aprove the reserve to transfer tokens
      await token1.approve(liquidityReserve2.address, amountToDeposit, {from: liquidityProvider2});
      await token2.approve(liquidityReserve2.address, amountToDeposit, {from: liquidityProvider2});

      let providerBalanceToken1Before = await token1.balanceOf.call(liquidityProvider2);
      let providerBalanceToken2Before = await token2.balanceOf.call(liquidityProvider2);

      //deposit tokens
      await liquidityReserve2.deposit(token1.address, amountToDeposit, {from: liquidityProvider2});
      await liquidityReserve2.deposit(token2.address, amountToDeposit, {from: liquidityProvider2});

      let providerBalanceToken1After = await token1.balanceOf.call(liquidityProvider2);
      let providerBalanceToken2After = await token1.balanceOf.call(liquidityProvider2);
      let reserveToken1Balance = await liquidityReserve2.balance.call(token1.address);
      let reserveToken2Balance = await liquidityReserve2.balance.call(token2.address);

      assert.equal(providerBalanceToken1Before-providerBalanceToken1After, amountToDeposit, "Wrong deposited amount");
      assert.equal(providerBalanceToken2Before-providerBalanceToken2After, amountToDeposit, "Wrong deposited amount");
      assert.equal(reserveToken1Balance.toString(), amountToDeposit.toString(), "Wrong reserve balance");
      assert.equal(reserveToken2Balance.toString(), amountToDeposit.toString(), "Wrong reserve balance");
    });
  });

  describe("Withdraw", async() => {
    const amountToWithdraw = ether("100");

    describe("Liquidity provider withdraw", async() => {
      it("should revert withdrawing during locking period and price locking", async() => {
        await liquidityReserve1.withdraw(token1.address, amountToWithdraw, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
      });

      it("withdraw when price locking condition is valid even if locking period is not valid", async() => {
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

        await liquidityReserve1.withdraw(token1.address, amountToWithdraw, {from: liquidityProvider1});

        let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
        assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
      }); 

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

        await liquidityReserve1.withdraw(token1.address, amountToWithdraw, {from: liquidityProvider1});

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

        await liquidityReserve1.withdraw(token1.address, amountToWithdraw, {from: liquidityProvider1});

        let reserveBalanceAfter = await liquidityReserve1.balance.call(token1.address);
        let providerBalanceAfter = await token1.balanceOf.call(liquidityProvider1);
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
        assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
      }); 

      it("should revert another liqudity provider withdrawing from liquidity reserve", async() => {
        await liquidityReserve1.withdraw(token1.address, amountToWithdraw, {from: liquidityProvider2}).should.be.rejectedWith(EVMRevert);
      });

    });

    describe("Settlement contract withdraw", async() => {
      it("settlement contract withdraw tokens from liquidity reserve", async() => {
        let alkemiSettlementBalanceBefore = await token1.balanceOf(alkemiSettlement.address);
        let reserveBalanceBefore = await liquidityReserve1.balance(token1.address);
  
        //withdraw tokens
        await alkemiSettlement.withdrawFromLiquidityReserve(liquidityReserve1.address, token1.address, amountToWithdraw, {from: alkemiTeam});
        
        let alkemiSettlementBalanceAfter = await token1.balanceOf(alkemiSettlement.address);
        let reserveBalanceAfter = await liquidityReserve1.balance(token1.address);
  
        assert.equal(parseInt(alkemiSettlementBalanceBefore)+parseInt(amountToWithdraw), alkemiSettlementBalanceAfter, "Wrong settlement contract balance");
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
      });  
    });


  });

});