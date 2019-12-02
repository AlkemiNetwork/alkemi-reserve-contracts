pragma solidity ^0.5.0;

import "../interfaces/IOracleGuard.sol";
import "../interfaces/IAlkemiToken.sol";

contract Oracle {

  // mapping of banned nodes by settlement id
  mapping(uint256 => address[]) public settlementBannedNode;

  // mapping of book hash by settlement id
  mapping (uint256 => bytes32) public settlementBookHash;

  // mapping settlement voting by book hash
  mapping (bytes32 => SettlementVoting) public settlementVoting;

  mapping(bytes32 => mapping (address => bool)) public accountingVotedNode;
    
  IOracleGuard internal _oracleGuard;

  enum Vote {
    YES,
    NO
  }

  struct SettlementVoting {
    address node;
    bytes32 bookHash;
    uint256 minimumVotes;
    uint256 yesVotes;
    uint256 noVotes;
    address[] exchangesAddresses;
    address[] surplusTokens;
    address[] deficitTokens;
    uint256[] surplus;
    uint256[] deficit;
  }

  event RequestAccountingBook(uint256 indexed settlementId);
  event RequestVote(uint256 indexed settlementId, bytes32 bookHash);
  event RequestStopTrade();
  event RequestContinueTrade();

  function submitBook(
    address[] calldata exchangesAddresses,
    address[] calldata surplusTokens,
    address[] calldata deficitTokens,
    uint256[] calldata surplus,
    uint256[] calldata deficit,
    uint256 _settlementId,
    bytes32 _bookHash
  ) external {
    require(_oracleGuard.isNodeAuth(msg.sender) == true, "Oracle: not authorized node");
    require(settlementBookHash[_settlementId] == bytes32(0), "Oracle: book already submitted for this settlement id");

    uint256 _minimumVotes = _oracleGuard.nodesAvailable();

    SettlementVoting memory voting = SettlementVoting({
      node: msg.sender,
      bookHash: _bookHash,
      minimumVotes: _minimumVotes,
      yesVotes: 0,
      noVotes: 0,
      exchangesAddresses: exchangesAddresses,
      surplusTokens: surplusTokens,
      deficitTokens: deficitTokens,
      surplus: surplus,
      deficit: deficit
    });

    settlementBookHash[_settlementId] = _bookHash;
    settlementVoting[_bookHash] = voting;

    // stop exchanges containers
    stopContainersTrading();
  }

  function settlementVote(uint256 _settlementId, bytes32 _bookHash, uint8 _vote) external {
    require(_oracleGuard.isNodeAuth(msg.sender) == true, "Oracle: not authorized node");
    require(settlementBookHash[_settlementId] == _bookHash, "Oracle: invalid accounting book to vote on for the current settlement id");
    require(accountingVotedNode[_bookHash][msg.sender] != true, "Oracle: node already voted");

    accountingVotedNode[_bookHash][msg.sender] = true;

    Vote vote = Vote(_vote);

    SettlementVoting storage voting = settlementVoting[_bookHash];
    if(vote == Vote.YES) {
      voting.yesVotes++;

      if(voting.yesVotes >= voting.minimumVotes) {
        // un-ban nodes
       _oracleGuard.authNode(settlementBannedNode[_settlementId]);

       //call settlement contract
      }
    }
    else {
      voting.noVotes++;

      if(voting.noVotes >= voting.minimumVotes) {
        // ban book submitter for the current settlement id
        _oracleGuard.dropNode(voting.node);
        settlementBannedNode[_settlementId].push(voting.node);
        settlementBookHash[_settlementId] == bytes32(0);

        // request re-submittig book from the rest of the nodes
        requestAccountingBook(_settlementId);
      }
    }
  }

  function restartContainersTrading() external {
    require(_oracleGuard.isContractAuth(msg.sender) == true, "Oracle: not authorized contract");

    emit RequestContinueTrade();
  }

  function requestAccountingBook(uint256 _settlementId) internal {
    emit RequestAccountingBook(_settlementId);
  }

  function stopContainersTrading() internal {
    emit RequestStopTrade();
  }
}