const {
  BN,
  constants,
  expectEvent,
  expectRevert,
  ether
} = require("@openzeppelin/test-helpers");
  
const BigNumber = require('bignumber.js');
const EVMRevert = require('./helpers/EVMRevert').EVMRevert;

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
    
    // Mint tokens for liquidity providers (testing purpose)
    await tokenMock.mint(liquidityProvider1, supplyToMint);
    await tokenMock.mint(liquidityProvider2, supplyToMint);
    await tokenMock.mint(liquidityProvider3, supplyToMint);
    await tokenMock.mint(liquidityProvider4, supplyToMint);
    await tokenMock.mint(liquidityProvider5, supplyToMint);
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
    const amountToDeposit = ether("300");
    
    it("deposit tokens into liquidity reserve", async() => {
      //aprove the reserve to transfer tokens
      await tokenMock.approve(liquidityReserve1.address, amountToDeposit, {from: liquidityProvider1});

      let providerBalanceBefore = await tokenMock.balanceOf(liquidityProvider1);

      //deposit tokens
      await liquidityReserve1.deposit(tokenMock.address, amountToDeposit, {from: liquidityProvider1});
      
      let providerBalanceAfter = await tokenMock.balanceOf(liquidityProvider1);
      let reserveBalanceAfter = await tokenMock.balanceOf(liquidityReserve1.address);

      assert.equal(providerBalanceBefore-providerBalanceAfter, amountToDeposit, "Wrong deposited amount");
      assert.equal(reserveBalanceAfter.toString(), amountToDeposit.toString(), "Wrong reserve balance");
    });
    
  });

});