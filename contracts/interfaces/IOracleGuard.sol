pragma solidity ^0.5.0;


/**
 * @title IOracleGuard
 */
contract IOracleGuard {
  /**
   * @dev Auth node to call oracle
   * @notice can only be called from an authorized sender
   * @param a node address
   */
  function authNode(address a) external;

  /**
   * @dev Ban node
   * @notice can only be called from an authorized sender
   * @param a node address
   */
  function dropNode(address a) external;

  /**
   * @dev Auth node to call oracle
   * @notice can only be called from an authorized sender
   * @param a nodes addresses
   */
  function authNode(address[] calldata a) external;

  /**
   * @dev Ban node
   * @notice can only be called from an authorized sender
   * @param a nodes addresses
   */
  function dropNode(address[] calldata a) external;

  /**
   * @dev Get Alkemi Token address
   */
  function token() public view returns (address);

}