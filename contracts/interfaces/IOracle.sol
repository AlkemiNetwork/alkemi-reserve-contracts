pragma solidity ^0.5.0;


/**
 * @title IOracle
 */
contract IOracle {
  function restartContainersTrading(uint256 settlementId, uint256 settlementTime) external;
}