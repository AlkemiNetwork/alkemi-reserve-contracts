pragma solidity ^0.5.0;


/**
  * @title ILiquidityReserve
  */
contract ILiquidityReserve {

  /**
   * @dev check if reserve is active
   */
  function isActive() external view returns(bool);

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
   * @dev Returns true if one of the liquidity provder's conditions are valid
   */
  function isUnlocked(address _token) public view returns (bool);

  /**
   * @dev Returns true if the beneficiary is the current reserve.
   */
  function isBeneficiary() external view returns (bool);

  function balance(address _token) public view returns (uint256);
}