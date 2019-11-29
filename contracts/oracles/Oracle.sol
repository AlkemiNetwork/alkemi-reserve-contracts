pragma solidity ^0.5.0;

import "../interfaces/IOracleGuard.sol";
import "../interfaces/IAlkemiToken.sol";

contract Oracle {

  // mapping of banned nodes by settlement id
  mapping(uint256 => address[]) public settlementBannedNode;

  // mapping of book hash by settlement id
  mapping (uint256 => bytes32) public settlementBookHash;

  // mapping accounting book by book hash
  mapping (bytes32 => AccountingBook) public accountingBook;

  mapping(bytes32 => mapping (address => bool)) public accountingVotedNode;
    
  IOracleGuard internal _oracleGuard;

  enum Vote {
    YES,
    NO
  }

  // TODO: define book data structure
  struct AccountingBook {
    address node;
    uint256 minimumVotes;
    uint256 yesVotes;
    uint256 noVotes;
  }

  event RequestAccountingBook(uint256 indexed settlementId);
  event RequestVote(uint256 indexed settlementId, bytes32 bookHash);
  event RequestStopTrade();
  event RequestContinueTrade();

  // TODO: add book data params
  function submitBook(uint256 _settlementId, bytes32 _bookHash) external {
    require(_oracleGuard.isNodeAuth(msg.sender) == true, "Oracle: not authorized node");
    require(settlementBookHash[_settlementId] == bytes32(0), "Oracle: book already submitted for this settlement id");

    uint256 _minimumVotes = _oracleGuard.nodesAvailable();

    AccountingBook memory book = AccountingBook({
      node: msg.sender,
      minimumVotes: _minimumVotes,
      yesVotes: 0,
      noVotes: 0
    });

    settlementBookHash[_settlementId] = _bookHash;
    accountingBook[_bookHash] = book;
  }

  function voting(uint256 _settlementId, bytes32 _bookHash, uint8 _vote) external {
    require(_oracleGuard.isNodeAuth(msg.sender) == true, "Oracle: not authorized node");
    require(settlementBookHash[_settlementId] == _bookHash, "Oracle: invalid accounting book to vote on for the current settlement id");
    require(accountingVotedNode[_bookHash][msg.sender] != true, "Oracle: node already voted");

    accountingVotedNode[_bookHash][msg.sender] = true;

    Vote vote = Vote(_vote);

    AccountingBook storage book = accountingBook[_bookHash];
    if(vote == Vote.YES) {
      book.yesVotes++;

      if(book.yesVotes >= book.minimumVotes) {
        // un-ban nodes
       _oracleGuard.authNode(settlementBannedNode[_settlementId]);

       //call settlement contract

       // stop exchanges containers
       stopContainersTrading();
      }
    }
    else {
      book.noVotes++;

      if(book.noVotes >= book.minimumVotes) {
        // ban book submitter for the current settlement id
        _oracleGuard.dropNode(book.node);
        settlementBannedNode[_settlementId].push(book.node);
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