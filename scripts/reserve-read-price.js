const LiquidityReserve = artifacts.require("LiquidityReserve");

/*
  This script makes it easy to read the asset price
  of the requesting contract.
*/

module.exports = async callback => {
  const reserve = await LiquidityReserve.deployed();
  const price = await reserve.oraclePrice.call()
  callback(price)
}
