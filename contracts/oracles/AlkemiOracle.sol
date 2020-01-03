pragma solidity ^0.5.0;

import "../interfaces/IOracleGuard.sol";
import "../interfaces/IAlkemiNetwork.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract AlkemiOracle {
    using SafeMath for uint256;

    /// @notice mapping of banned nodes by settlement id
    mapping(uint256 => address[]) public settlementBannedNode;

    /// @notice mapping of book hash by settlement id
    mapping(uint256 => bytes32) public settlementBookHash;

    /// @notice mapping settlement voting by book hash
    mapping(bytes32 => SettlementVoting) public settlementVoting;

    /// @notice mapping of voted nodes by book hash
    mapping(bytes32 => mapping(address => bool)) public accountingVotedNode;

    /// @notice oracle guard instance
    address public oracleGuard;

    /// @notice alkemi network instance
    address public alkemiNetwork;

    enum Vote {YES, NO}

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
    event RequestContinueTrade(
        uint256 settlementId,
        uint256 settlementTimeStamp
    );

    constructor(address _oracleGuard, address _alkemiNetwork) public {
        require(
            _oracleGuard != address(0),
            "AlkemiOracle: invalid oracle guard address"
        );
        require(
            _alkemiNetwork != address(0),
            "AlkemiOracle: invalid alkemi network address"
        );

        oracleGuard = _oracleGuard;
        alkemiNetwork = _alkemiNetwork;
    }

    function getSettlementId() external view returns (uint256) {
        require(
            IOracleGuard(oracleGuard).isNodeAuth(msg.sender) == true,
            "Oracle: not authorized node"
        );

        return IAlkemiNetwork(alkemiNetwork).currentSettlementId();
    }

    /**
    * @notice submit book hash and settlement details to vote for
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
        require(
            IOracleGuard(oracleGuard).isNodeAuth(msg.sender) == true,
            "Oracle: not authorized node"
        );
        require(
            settlementBookHash[_settlementId] == bytes32(0),
            "Oracle: book already submitted for this settlement id"
        );

        uint256 _minimumVotes = IOracleGuard(oracleGuard).nodesCounter();

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

        stopContainersTrading(_settlementId);

        // Request vote from nodes
        requestNodesVoting(_settlementId, _bookHash);
    }

    function settlementVote(
        uint256 _settlementId,
        bytes32 _bookHash,
        uint8 _vote
    ) external {
        require(
            IOracleGuard(oracleGuard).isNodeAuth(msg.sender) == true,
            "Oracle: not authorized node"
        );
        require(
            settlementBookHash[_settlementId] == _bookHash,
            "Oracle: invalid accounting book to vote on for the current settlement id"
        );
        require(
            accountingVotedNode[_bookHash][msg.sender] != true,
            "Oracle: node already voted"
        );

        accountingVotedNode[_bookHash][msg.sender] = true;

        Vote vote = Vote(_vote);

        SettlementVoting storage voting = settlementVoting[_bookHash];
        if (vote == Vote.YES) {
            voting.yesVotes++;

            if (
                (voting.yesVotes >= voting.minimumVotes) &&
                (voting.isSettled == false)
            ) {
                voting.isSettled = true;
                // un-ban nodes
                IOracleGuard(oracleGuard).authNode(
                    settlementBannedNode[_settlementId]
                );

                //call settlement contract
                IAlkemiNetwork(alkemiNetwork).doSettlement(
                    voting.exchangesAddresses,
                    voting.surplusTokensAddresses,
                    voting.deficitTokensAddresses,
                    voting.surplus,
                    voting.deficit
                );

                emit Settlement(voting.settlementId, voting.bookHash);
            }
        } else {
            voting.noVotes++;

            if (voting.noVotes >= voting.minimumVotes) {
                // ban book submitter for the current settlement id
                IOracleGuard(oracleGuard).dropNode(voting.node);
                settlementBannedNode[_settlementId].push(voting.node);
                settlementBookHash[_settlementId] == bytes32(0);

                // request re-submittig book from the rest of the nodes
                requestAccountingBook(_settlementId);
            }
        }
    }

    function requestNodesVoting(uint256 _settlementId, bytes32 _bookHash)
        internal
    {
        emit RequestVote(_settlementId, _bookHash);
    }

    function requestAccountingBook(uint256 _settlementId) internal {
        emit RequestAccountingBook(_settlementId);
    }

    function restartContainersTrading(
        uint256 settlementId,
        uint256 settlementTime
    ) external {
        require(
            IOracleGuard(oracleGuard).isContractAuth(msg.sender) == true,
            "Oracle: not authorized contract"
        );

        emit RequestContinueTrade(settlementId, settlementTime);
    }

    function stopContainersTrading(uint256 settlementId) internal {
        emit RequestStopTrade(settlementId);
    }
}
