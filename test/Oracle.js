const {
  BN,
  constants,
  expectEvent,
  expectRevert,
  ether
} = require("@openzeppelin/test-helpers");
  
const truffleAssert = require('truffle-assertions');
const BigNumber = require('bignumber.js');
const EVMRevert = require('./helpers/EVMRevert').EVMRevert;

const ZERO_ADDR = '0x0000000000000000000000000000000000000000';

const TokenMock = artifacts.require("TokenMock");
const AlkemiSettlementMock = artifacts.require("AlkemiSettlementMock");
const OracleGuard = artifacts.require("OracleGuard");
const Oracle = artifacts.require("Oracle");

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();

contract('Oracles', ([alkemiTeam, oracle1, oracle2, oracle3, , exchange1, exchange2, random]) => {
  const minimumTokens = ether("200");   // Required minimum token for oracle to submit book
  let DAI, USDC, alkemiToken, alkemiSettlement, oracleGuard, oracle;

  before(async() => {
    // ERC20 token mock for testing
    DAI = await TokenMock.new({
      from: alkemiTeam
    });
    USDC = await TokenMock.new({
      from: alkemiTeam
    });
    alkemiToken = await TokenMock.new({
      from: alkemiTeam
    });

    alkemiSettlement = await AlkemiSettlementMock.new({
      from: alkemiTeam
    });
    
    oracleGuard = await OracleGuard.new(
      minimumTokens,
      { from: alkemiTeam }
    );
       
    oracle = await Oracle.new(
      alkemiSettlement.address,
      oracleGuard.address,
      { from: alkemiTeam }
    );

    await oracleGuard.setOracleContract(oracle.address);
    await oracleGuard.setTokenContract(alkemiToken.address);
           
    // Mint tokens for oracles(nodes)
    await alkemiToken.mint(oracle1, minimumTokens);
    await alkemiToken.mint(oracle2, minimumTokens);
    await alkemiToken.mint(oracle3, minimumTokens);

    // Authenticate oracles(nodes)
    await oracleGuard.registerNode([oracle1, oracle2, oracle3], { from: alkemiTeam });
  });

  describe("Oracle Guard", async() => {
    it("check deployment", async() => {
      let _oracleToken = await oracleGuard.token();
      let _oracleAddress = await oracleGuard.oracle();
      let _requiredTokens = await oracleGuard.requiredToken();
      let _oraclesAvailable = await oracleGuard.nodesAvailable();
      assert.equal(_oracleToken, alkemiToken.address, "Wrong Alkemi Token address");
      assert.equal(_oracleAddress, oracle.address, "Wrong oracle contract address");
      assert.equal(_requiredTokens.toString(), minimumTokens.toString(), "Wrong required token balance");
      assert.equal(_oraclesAvailable, 3, "Wrong number of available nodes");
    });
  });

});