const LiquidityReserve = artifacts.require("LiquidityReserve.sol");

const config = require("./config.json");

/*
  This script is meant to assist with depositing
  an ERC20 asset into a created reserve
*/

module.exports = async function(callback) {
  try {
    if(config.devchain.reserve == '') {
      console.log("Specify a liquidity reserve address in the config file");
      return;
    }
    const liquidityReserve = await LiquidityReserve.at(config.devchain.reserve);
    console.log("Liquidity Reserve: ", liquidityReserve.address);

    const tx = await liquidityReserve.deposit(
        config.devchain.depositAmount
    );

    callback(tx.tx);
  }
  catch(err) {
    callback(err);
  }
  
}
