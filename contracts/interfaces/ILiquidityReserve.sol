pragma solidity ^0.5.0;


/**
  * @title ILiquidityReserve
  */
contract ILiquidityReserve {

  /**
   * @dev Returns true if the beneficiary is the current reserve.
   */
  function isBeneficiary() external view returns (bool);

  /**
   * @notice Deposit `_value` `_token` to the reserve
   * @param _token Address of the token being transferred
   * @param _value Amount of tokens being transferred
   */
  function deposit(address _token, uint256 _value) external payable;

   /**
   * @dev Set alkemi token address and minimum token amount
   * @notice this function can be only called from the Liquidity Reserve Manager
   * @param _alkemiToken Address of the alkemi token
   * @param _minAlkemiToken Minimum required amount of Alkemi token
   */
  function setToken(address _alkemiToken, uint256 _minAlkemiToken) external;

  function balance(address _token) public view returns (uint256);
}