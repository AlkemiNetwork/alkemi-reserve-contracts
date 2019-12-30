const { helpers, generated } = require('chainlink');
const Token = artifacts.require("TokenMock.sol");
const AlkemiNetwork = artifacts.require("AlkemiNetwork.sol");

/*
  This script is meant to assist with creating a 
  liquidity reserve. It will deploy an ERC20 token, 
  a mock for the LINK Token and will make a call to 
  the Alkemi Network contract to create a reserve.
*/

const ZERO_ADDR = '0x0000000000000000000000000000000000000000';
const dayTime = 24 * 3600;
const now = Math.floor(Date.now() / 1000);
const lockingPeriod = now + dayTime;

module.exports = async callback => {
    const token = await Token.deploy("Token A", "TOA", 18);
    const linkToken = await helpers.create(generated.LinkTokenFactory, alkemiTeam).deploy();
    const alkemiNetwork = await AlkemiNetwork.deployed();
    const tx = await alkemiNetwork.createLiquidityReserve(
        linkToken.address,
        ZERO_ADDR,
        token.address,
        lockingPeriod,
        200,
        1
    );
    callback(tx.tx);
}
