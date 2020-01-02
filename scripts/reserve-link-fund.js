//const { helpers, generated } = require("chainlink");
//const LiquidityReserve = artifacts.require("LiquidityReserve");

/*
  This script is meant to assist with funding the liquidity
  reserve contract with LINK. It will send 1 LINK to the requesting
  contract for ease-of-use. Any extra LINK present on the contract
  can be retrieved by calling the withdrawLink() function.
*/

//const payment = process.env.TRUFFLE_CL_BOX_PAYMENT || '1000000000000000000';

//module.exports = async callback => {
//  const linkToken = await helpers.create(generated.LinkTokenFactory, alkemiTeam).deploy();
//  const liquidityReserve = await LiquidityReserve.deployed();
//  console.log('Funding contract:', liquidityReserve.address);
//  const tx = await linkToken.transfer(liquidityReserve.address, payment);
//  callback(tx.tx);
//}
