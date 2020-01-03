pragma solidity ^0.5.0;

/**
 * @title IOracleGuard
 */
contract IOracleGuard {
    /**
   * @dev Auth node to call oracle
   * @notice can only be called from an authorized sender
   * @param a nodes addresses
   */
    function authNode(address[] calldata a) external;

    /**
   * @dev Ban node
   * @notice can only be called from an authorized sender
   * @param a node address
   */
    function dropNode(address a) external;

    /**
   * @dev Check if contract is authorized to call oracle
   * @param _contract contract address
   * @return true if authorized
   */
    function isContractAuth(address _contract) external view returns (bool);

    /**
   * @dev Check if node is authorized to submit book to oracle
   * @param _node node address
   * @return true if authorized
   */
    function isNodeAuth(address _node) external view returns (bool);

    /**
   * @dev check if node is banned
   * @param _node node address
   * @return true if banned
   */
    function isNodeBan(address _node) external view returns (bool);

    /**
   * @dev check if node is slashed (node does not have minimum token amount)
   * @param _node node address
   * @return true if banned
   */
    function isNodeSlashed(address _node) external view returns (bool);

    /**
   * @dev Get Alkemi Token address
   */
    function token() public view returns (address);

    /**
   * @dev Get the amount of required tokens to run node
   */
    function requiredToken() public view returns (uint256);

    /**
   * @dev Get number of nodes available to vote
   */
    function nodesCounter() public view returns (uint256);

}
