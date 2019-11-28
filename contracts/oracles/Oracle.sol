pragma solidity ^0.5.0;

import "../interfaces/IOracleGuard.sol";

contract Oracle {

  // mapping of book hash by settlement id
  mapping (uint256 => bytes32) public settlementBookHash;

  // mapping accounting book by book hash
  mapping (bytes32 => AccountingBook) public accountingBook;

  // mapping of votes by book hash
  //mapping (bytes32 => Vote) public bookVote;
    
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

  //struct Vote {
    //bytes32 account;
  //}

  event RequestAccountingBook(uint256 indexed settlementId);
  event RequestVote(uint256 indexed settlementId, bytes32 bookHash);
  event RequestStopTrade();
  event RequestContinueTrade();

  // TODO: add book data params
  function submitBook(uint256 _settlementId, bytes32 _bookHash) external {
    require(_oracleGuard.isNodeAuth(msg.sender) == true, "Oracle: not authorized node");

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

    Vote vote = Vote(_vote);

    AccountingBook storage book = accountingBook[_bookHash];
    if(vote == Vote.YES) {
      book.yesVotes++;
    }
    else {
      book.noVotes++;
    }
  }

  function restartContainersTrading() external {
    require(_oracleGuard.isContractAuth(msg.sender) == true, "Oracle: not authorized contract");

    emit RequestContinueTrade();
  }

  function stopContainersTrading() internal {
    emit RequestStopTrade();
  }
}