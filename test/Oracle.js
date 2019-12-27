const {
  ether
} = require("@openzeppelin/test-helpers");
  
const truffleAssert = require('truffle-assertions');
const BigNumber = require('bignumber.js');
const EVMRevert = require('./helpers/EVMRevert').EVMRevert;

const EtherTokenConstantMock = artifacts.require("EtherTokenConstantMock");
const TokenMock = artifacts.require("TokenMock");
const OracleGuard = artifacts.require("OracleGuard");
const AlkemiOracle = artifacts.require("AlkemiOracle");
const AlkemiNetworkMock = artifacts.require("AlkemiNetworkMock");

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();

contract('Oracle System', ([alkemiTeam, oracle1, oracle2, oracle3, exchange1, exchange2, random]) => {
  const minimumTokens = ether("200"); // Required minimum token for oracle to submit book
  const _currentSettlementId = 1;

  let settlementDetails, ETH, USDC, alkemiToken, alkemiNetwork, oracleGuard, oracle;

  before(async() => {
    // ERC20/ETH token mock for testing
    const etherMock = await EtherTokenConstantMock.new({ from: alkemiTeam });
    ETH = await etherMock.getETHConstant();
    USDC = await TokenMock.new(
      "USDC",
      "USDC",
      18,
      { from: alkemiTeam }
    );
    alkemiToken = await TokenMock.new(
      "Alkemi Token",
      "ALK",
      18,
      { from: alkemiTeam }
    );

    alkemiNetwork = await AlkemiNetworkMock.new(
      { from: alkemiTeam }
    );
    
    oracleGuard = await OracleGuard.new(
      minimumTokens,
      { from: alkemiTeam }
    );
       
    oracle = await AlkemiOracle.new(
      oracleGuard.address,
      alkemiNetwork.address,
      { from: alkemiTeam }
    );

    await oracleGuard.setOracleContract(oracle.address);
    await oracleGuard.setTokenContract(alkemiToken.address);
    await oracleGuard.authContract([alkemiNetwork.address], { from: alkemiTeam });

    await alkemiNetwork.setAlkemiOracle(oracle.address, { from: alkemiTeam });
           
    // Mint tokens for oracles(nodes)
    await alkemiToken.mint(oracle1, minimumTokens);
    await alkemiToken.mint(oracle2, minimumTokens);
    await alkemiToken.mint(oracle3, minimumTokens);

    await oracleGuard.registerNode([oracle1, oracle2, oracle3], { from: alkemiTeam });

    /*
     * Exchange1: +40ETH, -150USDC
     * Exchange2: +300USDC, -40ETH 
     */
    settlementDetails = {
      exchangesAddresses: [exchange1, exchange2],
      surplusTokensAddresses: [ETH, USDC.address], // address(0) = ETH
      deficitTokensAddresses: [USDC.address, ETH],
      surplus: [ether("40"), ether("300")],
      deficit: [ether("150"), ether("40")],
      _settlementId: _currentSettlementId,
      _bookHash: web3.utils.sha3(web3.utils.toHex("book1hash"))
    };
  });

  describe("Oracle Guard", async() => {
    it("check deployment", async() => {
      let _oracleToken = await oracleGuard.alkemiToken.call();
      let _oracleAddress = await oracleGuard.alkemiOracle.call();
      let _requiredTokens = await oracleGuard.requiredTokens.call();
      let _oraclesAvailable = await oracleGuard.nodesCounter.call();
      assert.equal(_oracleToken, alkemiToken.address, "Wrong Alkemi Token address");
      assert.equal(_oracleAddress, oracle.address, "Wrong oracle contract address");
      assert.equal(_requiredTokens.toString(), minimumTokens.toString(), "Wrong required token balance");
      assert.equal(_oraclesAvailable, 3, "Wrong number of available nodes");
    });
  });

  describe("Oracle", async() => {

    describe("Settlement id", async() => {
      it("get settlement id", async() => {
        assert.equal((await oracle.getSettlementId({ from: oracle1 })).toString(), _currentSettlementId, "Wrong settlement id");
        assert.equal((await oracle.getSettlementId({ from: oracle2 })).toString(), _currentSettlementId, "Wrong settlement id");
        assert.equal((await oracle.getSettlementId({ from: oracle3 })).toString(), _currentSettlementId, "Wrong settlement id");
      });
  
      it("should revert getting settlement id from unauthorized node", async() => {
        await oracle.getSettlementId({ from: random }).should.be.rejectedWith(EVMRevert);
      });  
    });
  });

  describe("Submit book hash and settlement details", async() => {
    it("should revert submitting from unauthorized node", async() => {
      await oracle.submitBook(
        settlementDetails.exchangesAddresses,
        settlementDetails.surplusTokensAddresses,
        settlementDetails.deficitTokensAddresses,
        settlementDetails.surplus,
        settlementDetails.deficit,
        settlementDetails._settlementId,
        settlementDetails._bookHash,
        { from: random }
      ).should.be.rejectedWith(EVMRevert);
    });

    it("submit book", async() => {
      let tx = await oracle.submitBook(
        settlementDetails.exchangesAddresses,
        settlementDetails.surplusTokensAddresses,
        settlementDetails.deficitTokensAddresses,
        settlementDetails.surplus,
        settlementDetails.deficit,
        settlementDetails._settlementId,
        settlementDetails._bookHash,
        { from: oracle1 }
      );

      let settlementVotingObject = await oracle.settlementVoting(settlementDetails._bookHash);
      assert.equal(settlementVotingObject.node, oracle1, "Wrong book node submitter");
      assert.equal(await oracle.settlementBookHash(settlementDetails._settlementId), settlementDetails._bookHash, "Wrong book hash for settlement id");
      // check stop container trading event
      truffleAssert.eventEmitted(tx, 'RequestStopTrade');
      truffleAssert.eventEmitted(tx, 'RequestVote');
    });

    it("should revert submitting book for a settlement id that have already a submitted book and settlement details", async() => {
      await oracle.submitBook(
        settlementDetails.exchangesAddresses,
        settlementDetails.surplusTokensAddresses,
        settlementDetails.deficitTokensAddresses,
        settlementDetails.surplus,
        settlementDetails.deficit,
        settlementDetails._settlementId,
        settlementDetails._bookHash,
        { from: oracle2 }
      ).should.be.rejectedWith(EVMRevert);
    });
  });

  describe("Vote for submitted book", async() => {
    it("should revert voting from unauthorized node", async() => {
      await oracle.settlementVote(
        settlementDetails._settlementId,
        settlementDetails._bookHash,
        1, // Yes vote
        { from: random }
      ).should.be.rejectedWith(EVMRevert);
    });  

    it("should do settlement if Yes consensus reached", async() => {
      await oracle.settlementVote(
        settlementDetails._settlementId,
        settlementDetails._bookHash,
        0, // Yes vote
        { from: oracle1 }
      );

      let tx1 = await oracle.settlementVote(
        settlementDetails._settlementId,
        settlementDetails._bookHash,
        0, // Yes vote
        { from: oracle2 }
      );

      assert.equal(await oracle.accountingVotedNode(settlementDetails._bookHash, oracle1), true, "Oracle should have voted");
      assert.equal(await oracle.accountingVotedNode(settlementDetails._bookHash, oracle2), true, "Oracle should have voted");
      
      // check settlement event
      truffleAssert.eventEmitted(tx1, 'Settlement');
      truffleAssert.eventNotEmitted(tx1, 'RequestAccountingBook');

      let tx2 = await oracle.settlementVote(
        settlementDetails._settlementId,
        settlementDetails._bookHash,
        0, // Yes vote
        { from: oracle3 }
      );
      // check settlement event not emitted
      truffleAssert.eventNotEmitted(tx2, 'Settlement');
      truffleAssert.eventNotEmitted(tx2, 'RequestAccountingBook');
    });

  });

});