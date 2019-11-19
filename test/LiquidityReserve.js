const {
  BN,
  constants,
  expectEvent,
  expectRevert,
  ether
} = require("@openzeppelin/test-helpers");
  
const BigNumber = require('bignumber.js');
const EVMRevert = require('./helpers/EVMRevert').EVMRevert;
const increaseTime = require('./helpers/increaseTime');
const increaseTimeTo = increaseTime.increaseTimeTo;

const ZERO_ADDR = '0x0000000000000000000000000000000000000000';

const AlkemiToken = artifacts.require("AlkemiToken");
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

  let tokenMock, alkemiSettlement, liquidityReserveManager, liquidityReserve1;

  before(async() => {
    // ERC20 token mock for testing
    tokenMock = await AlkemiToken.new({
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

    let liquidityReserve1Address = await liquidityReserveManager.liquidityReserveOf(liquidityProvider1);

    liquidityReserve1 = await LiquidityReserve.at(liquidityReserve1Address);    
    
    // Mint tokens
    await tokenMock.mint(alkemiSettlement.address, supplyToMint);
    await tokenMock.mint(liquidityProvider1, supplyToMint);
    await tokenMock.mint(liquidityProvider2, supplyToMint);
    await tokenMock.mint(liquidityProvider3, supplyToMint);
    await tokenMock.mint(liquidityProvider4, supplyToMint);
    await tokenMock.mint(liquidityProvider5, supplyToMint);
    await tokenMock.mint(random, supplyToMint);
  });

  describe("Liquidity Reserve", async() => {
    it("check deployment", async() => {
      let _liquidityReserveProvider = await liquidityReserve1.liquidityProvider();
      let _liquidityReserveManager = await liquidityReserve1.liquidityReserveManager();
      let _liquidityReserveSettlementContract = await liquidityReserve1.settlementContract();
      assert.equal(_liquidityReserveProvider, liquidityProvider1, "Wrong liquidity reserve owner");
      assert.equal(_liquidityReserveManager, liquidityReserveManager.address, "Wrong liqudity reserve manager address");
      assert.equal(_liquidityReserveSettlementContract, alkemiSettlement.address, "Wrong settlement contract address for the liquidity reserve");
    });
  });
  
  describe("Deposit", async() => {
    const amountToDeposit = ether("400");

    it("should revert when depositing token without aprroving transfer to the liquidity contract", async() => {
      await liquidityReserve1.deposit(tokenMock.address, amountToDeposit, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
    });

    it("should revert when depositing token from address that have no permission", async() => {
      //aprove the reserve to transfer tokens
      await tokenMock.approve(liquidityReserve1.address, amountToDeposit, {from: random});

      await liquidityReserve1.deposit(tokenMock.address, amountToDeposit, {from: random}).should.be.rejectedWith(EVMRevert);
    });

    it("should revert when depositing token amount equal to zero", async() => {
      //aprove the reserve to transfer tokens
      await tokenMock.approve(liquidityReserve1.address, amountToDeposit, {from: liquidityProvider1});

      await liquidityReserve1.deposit(tokenMock.address, ether("0"), {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
    });
    
    it("provider deposit tokens into liquidity reserve", async() => {
      //aprove the reserve to transfer tokens
      await tokenMock.approve(liquidityReserve1.address, amountToDeposit, {from: liquidityProvider1});

      let providerBalanceBefore = await tokenMock.balanceOf(liquidityProvider1);

      //deposit tokens
      await liquidityReserve1.deposit(tokenMock.address, amountToDeposit, {from: liquidityProvider1});
      
      let providerBalanceAfter = await tokenMock.balanceOf(liquidityProvider1);
      let reserveBalance = await liquidityReserve1.balance(tokenMock.address);

      assert.equal(providerBalanceBefore-providerBalanceAfter, amountToDeposit, "Wrong deposited amount");
      assert.equal(reserveBalance.toString(), amountToDeposit.toString(), "Wrong reserve balance");
    });

    it("settlement contract deposit tokens into liquidity reserve", async() => {
      //aprove the reserve to transfer tokens
      await alkemiSettlement.approveTokenTransfer(liquidityReserve1.address, tokenMock.address, amountToDeposit, {from: alkemiTeam});

      let alkemiSettlementBalanceBefore = await tokenMock.balanceOf(alkemiSettlement.address);
      let reserveBalanceBefore = await liquidityReserve1.balance(tokenMock.address);

      //deposit tokens
      await alkemiSettlement.depositIntoLiquidityReserve(liquidityReserve1.address, tokenMock.address, amountToDeposit, {from: alkemiTeam});
      
      let alkemiSettlementBalanceAfter = await tokenMock.balanceOf(alkemiSettlement.address);
      let reserveBalanceAfter = await liquidityReserve1.balance(tokenMock.address);

      assert.equal(alkemiSettlementBalanceBefore-alkemiSettlementBalanceAfter, amountToDeposit, "Wrong deposited amount");
      assert.equal(reserveBalanceAfter.toString(), parseInt(reserveBalanceBefore)+parseInt(amountToDeposit), "Wrong reserve balance");
    });    
  });

  describe("Withdraw", async() => {
    const amountToWithdraw = ether("110");

    describe("Liquidity provider withdraw", async() => {
      it("should revert withdrawing during locking period", async() => {
        await liquidityReserve1.withdraw(tokenMock.address, amountToWithdraw, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
      });

      it("should revert withdrawing during locking period even if price unlocking condition is set", async() => {
        let _lockingPricePosition = await liquidityReserve1.lockingPricePosition();
        let _lockingPrice = await liquidityReserve1.lockingPrice();
        let _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);

        if(_lockingPricePosition.toNumber() == 0) {
          await alkemiSettlement.decerementPriceOf(tokenMock.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);
          assert.ok(_oraclePrice < _lockingPrice, "Oracle price is not less than locking price");
        }
        else {
          await alkemiSettlement.incerementPriceOf(tokenMock.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);
          assert.ok(_oraclePrice > _lockingPrice, "Oracle price is not greater than locking price"); 
        }
        await liquidityReserve1.withdraw(tokenMock.address, amountToWithdraw, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
      }); 

      it("should revert withdrawing when price is locked even if locking period condition is set", async() => {
        //reset oracle price
        await alkemiSettlement.resetPriceOf(tokenMock.address, 200);
        // increase time
        await increaseTimeTo(lockingPeriod+1);

        let _lockingPricePosition = await liquidityReserve1.lockingPricePosition();
        let _lockingPrice = await liquidityReserve1.lockingPrice();
        let _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);

        if(_lockingPricePosition.toNumber() == 0) {
          await alkemiSettlement.incerementPriceOf(tokenMock.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);
          assert.ok(_oraclePrice > _lockingPrice, "Oracle price is not greater than locking price");
        }
        else {
          await alkemiSettlement.decerementPriceOf(tokenMock.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);
          assert.ok(_oraclePrice < _lockingPrice, "Oracle price is not less than locking price"); 
        }
        await liquidityReserve1.withdraw(tokenMock.address, amountToWithdraw, {from: liquidityProvider1}).should.be.rejectedWith(EVMRevert);
      }); 

      it("liquidity provider withdraw from liquidity reserve", async() => {
        //reset oracle price
        await alkemiSettlement.resetPriceOf(tokenMock.address, 200);

        let reserveBalanceBefore = await liquidityReserve1.balance(tokenMock.address);
        let providerBalanceBefore = await tokenMock.balanceOf(liquidityProvider1);

        let _lockingPricePosition = await liquidityReserve1.lockingPricePosition();
        let _lockingPrice = await liquidityReserve1.lockingPrice();
        let _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);

        if(_lockingPricePosition.toNumber() == 0) {
          await alkemiSettlement.decerementPriceOf(tokenMock.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);
          assert.ok(_oraclePrice < _lockingPrice, "Oracle price is not less than locking price");
        }
        else {
          await alkemiSettlement.incerementPriceOf(tokenMock.address, 10);
          _oraclePrice = await alkemiSettlement.priceOf(tokenMock.address);
          assert.ok(_oraclePrice > _lockingPrice, "Oracle price is not greater than locking price"); 
        }

        await liquidityReserve1.withdraw(tokenMock.address, amountToWithdraw, {from: liquidityProvider1});

        let reserveBalanceAfter = await liquidityReserve1.balance(tokenMock.address);
        let providerBalanceAfter = await tokenMock.balanceOf(liquidityProvider1);
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
        assert.equal(parseInt(providerBalanceBefore)+parseInt(amountToWithdraw), parseInt(providerBalanceAfter), "Wrong liqudity provider balance");
      }); 

      it("should revert withdrawing from another liqudity provider", async() => {
        await liquidityReserve1.withdraw(tokenMock.address, amountToWithdraw, {from: liquidityProvider2}).should.be.rejectedWith(EVMRevert);
      });

    });

    describe("Settlement contract withdraw", async() => {
      it("settlement contract withdraw tokens from liquidity reserve", async() => {
        let alkemiSettlementBalanceBefore = await tokenMock.balanceOf(alkemiSettlement.address);
        let reserveBalanceBefore = await liquidityReserve1.balance(tokenMock.address);
  
        //withdraw tokens
        await alkemiSettlement.withdrawFromLiquidityReserve(liquidityReserve1.address, tokenMock.address, amountToWithdraw, {from: alkemiTeam});
        
        let alkemiSettlementBalanceAfter = await tokenMock.balanceOf(alkemiSettlement.address);
        let reserveBalanceAfter = await liquidityReserve1.balance(tokenMock.address);
  
        assert.equal(parseInt(alkemiSettlementBalanceBefore)+parseInt(amountToWithdraw), alkemiSettlementBalanceAfter, "Wrong settlement contract balance");
        assert.equal(reserveBalanceBefore-amountToWithdraw, reserveBalanceAfter, "Wrong reserve balance");
      });  
    });


  });

});