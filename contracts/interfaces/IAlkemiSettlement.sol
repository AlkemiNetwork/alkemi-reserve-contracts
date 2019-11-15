pragma solidity ^0.5.0;


/**
  * @title IAlkemiSettlement
  */
contract IAlkemiSettlement {

  /**
   * @dev Returns the price of specific token
   * @notice to-be-updated when developing the settlement contract
   * @param _token token address
   * @return token price
   */
  function priceOf(address _token) external view returns (uint256) {
    return 200;
  }
}