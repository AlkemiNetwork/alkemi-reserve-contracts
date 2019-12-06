pragma solidity ^0.5.0;

import "../interfaces/IOracleGuard.sol";
import "../interfaces/IAlkemiToken.sol";
import "../interfaces/IAlkemiSettlement.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Oracle {

  using SafeMath for uint256;

  // mapping of banned nodes by settlement id
  mapping(uint256 => address[]) public settlementBannedNode;

  // mapping of book hash by settlement id
  mapping (uint256 => bytes32) public settlementBookHash;

  // mapping settlement voting by book hash
  mapping (bytes32 => SettlementVoting) public settlementVoting;

  mapping(bytes32 => mapping (address => bool)) public accountingVotedNode;

  IAlkemiSettlement internal _settlementContract;

  IOracleGuard internal _oracleGuard;

  enum Vote {
    YES,
    NO
  }

  struct SettlementVoting {
    address node;
    uint256 settlementId;
    bytes32 bookHash;
    uint256 minimumVotes;
    uint256 yesVotes;
    uint256 noVotes;
    bool isSettled;
    address[] exchangesAddresses;
    address[] surplusTokensAddresses;
    address[] deficitTokensAddresses;
    uint128[] surplus;
    uint128[] deficit;
  }

  event Settlement(uint256 indexed settlementId, bytes32 bookHash);
  event RequestAccountingBook(uint256 indexed settlementId);
  event RequestVote(uint256 indexed settlementId, bytes32 bookHash);
  event RequestStopTrade(uint256 indexed settlementId);
  event RequestContinueTrade(uint256 settlementId, uint256 settlementTimeStamp);

  constructor(address settlementContract, address oracleGuard) public {
    require(settlementContract != address(0), "Oracle: invalid settlement contract address");
    require(oracleGuard != address(0), "Oracle: invalid guard address");

    _settlementContract = IAlkemiSettlement(settlementContract);
    _oracleGuard = IOracleGuard(oracleGuard);
  }

  function getSettlementId() external view returns (uint256) {
    require(_oracleGuard.isNodeAuth(msg.sender) == true, "Oracle: not authorized node");

    return _settlementContract.settlementId();
  }

  /**
   * @dev submit book hash and settlement details to vote for
   * @param exchangesAddresses list of exchanges addresses
   * @param surplusTokensAddresses list of tokens for surplus
   * @param deficitTokensAddresses list of tokens for deficit
   * @param surplus list of surplus values
   * @param deficit list of deficit values
   * @param _settlementId book settlement id
   * @param _bookHash book hash
   */
  function submitBook(
    address[] calldata exchangesAddresses,
    address[] calldata surplusTokensAddresses,
    address[] calldata deficitTokensAddresses,
    uint128[] calldata surplus,
    uint128[] calldata deficit,
    uint256 _settlementId,
    bytes32 _bookHash
  ) external {
    require(_oracleGuard.isNodeAuth(msg.sender) == true, "Oracle: not authorized node");
    require(settlementBookHash[_settlementId] == bytes32(0), "Oracle: book already submitted for this settlement id");

    uint256 _minimumVotes = _oracleGuard.nodesAvailable();

    SettlementVoting memory voting = SettlementVoting({
      node: msg.sender,
      settlementId: _settlementId,
      bookHash: _bookHash,
      minimumVotes: _minimumVotes.div(2) + 1,
      yesVotes: 0,
      noVotes: 0,
      isSettled: false,
      exchangesAddresses: exchangesAddresses,
      surplusTokensAddresses: surplusTokensAddresses,
      deficitTokensAddresses: deficitTokensAddresses,
      surplus: surplus,
      deficit: deficit
    });

    settlementBookHash[_settlementId] = _bookHash;
    settlementVoting[_bookHash] = voting;

    // stop exchanges containers
    // thinking about moving this off-chain in the nodes side:
    // If votes yes, nodes receive a request with the settlement id, then nodes stop containers from trading the two pairs corresponding to the settlement id
    stopContainersTrading(_settlementId);

    // Request vote from nodes
    requestNodesVoting(_settlementId, _bookHash);
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

      if((voting.yesVotes >= voting.minimumVotes) && (voting.isSettled == false)) {
        voting.isSettled = true;
        // un-ban nodes
        _oracleGuard.authNode(settlementBannedNode[_settlementId]);

        //call settlement contract
        _settlementContract.doSettlement(
          voting.exchangesAddresses,
          voting.surplusTokensAddresses,
          voting.deficitTokensAddresses,
          voting.surplus,
          voting.deficit
        );

        emit Settlement(voting.settlementId, voting.bookHash);
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

  function requestNodesVoting(uint256 _settlementId, bytes32 _bookHash) internal {
    emit RequestVote(_settlementId, _bookHash);
  }

  function requestAccountingBook(uint256 _settlementId) internal {
    emit RequestAccountingBook(_settlementId);
  }

  function restartContainersTrading(uint256 settlementId, uint256 settlementTime) external {
    require(_oracleGuard.isContractAuth(msg.sender) == true, "Oracle: not authorized contract");

    emit RequestContinueTrade(settlementId, settlementTime);
  }

  function stopContainersTrading(uint256 settlementId) internal {
    emit RequestStopTrade(settlementId);
  }
}