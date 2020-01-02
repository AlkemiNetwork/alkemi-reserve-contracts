const LiquidityReserve = artifacts.require("LiquidityReserve.sol");

const config = require("./config.json");

/*
  This script is meant to assist with depositing
  an ERC20 asset into a created reserve
*/

module.exports = async function(callback) {
  try {
    const liquidityReserve = await LiquidityReserve.deployed();
    console.log("Liquidity Reserve: ", liquidityReserve.address);

    const tx = await liquidityReserve.deposit(
        config.depositAmount
    );

    callback(tx.tx);
  }
  catch(err) {
    callback(err);
  }
  
}
