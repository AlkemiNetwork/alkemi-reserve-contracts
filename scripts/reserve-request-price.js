const LiquidityReserve = artifacts.require("LiquidityReserve");

/*
  This script allows for a Chainlink request to be created from
  the Liquidity Reserve contract. Defaults to the Chainlink oracle address
  on this page: https://docs.chain.link/docs/available-oracles
*/

const oracleAddress =
  process.env.ORACLE_ADDRESS ||
  "0x7AFe1118Ea78C1eae84ca8feE5C65Bc76CcF879e";
const jobId =
  process.env.JOB_ID || "0e9e244b9c374cd1a5c714caf25b0be5";
const sym = process.env.SYM;
const market = process.env.MARKET || "USD";
const payment = process.env.PAYMENT || "1000000000000000000";
module.exports = async callback => {
  const reserve = await LiquidityReserve.deployed()
  console.log('Creating request on reserve:', reserve.address)
  const tx = await mc.createRequestTo(
    oracleAddress,
    web3.utils.toHex(jobId),
    sym,
    market,
    payment
  )
  callback(tx.tx)
}
