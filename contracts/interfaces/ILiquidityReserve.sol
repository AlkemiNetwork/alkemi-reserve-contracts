pragma solidity ^0.5.0;


/**
  * @title ILiquidityReserve
  */
contract ILiquidityReserve {

  /**
   * @notice Deposit `_value` `_token` to the reserve
   * @param _token Address of the token being transferred
   * @param _value Amount of tokens being transferred
   */
  function deposit(address _token, uint256 _value) external payable;

  /**
   * @dev Withdraw `_value` `_token` from the reserve
   * @notice this function can only be called by the liquidity provider or by the settlement contract
   * @param _token Address of the token being transferred
   * @param _value Amount of tokens being transferred
   */
  function withdraw(address _token, uint256 _value) external;

  /**
   * @dev Returns true if the beneficiary is the current reserve.
   */
  function isBeneficiary() external view returns (bool);

  function balance(address _token) public view returns (uint256);
}