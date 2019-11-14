pragma solidity ^0.5.0;


/**
  * @title ILiquidityReserveManager
  */
contract ILiquidityReserveManager {

  /**
   * @dev Manager can set the address of the new Owner here
   * @param _owner Address of the new Owner
   */
  function setNewOwner(address _owner) external;

  /**
   * @dev Set new Alkemi token for a specific liquidity reserve
   * @notice This function can only be called by the owner of the Liquidity Reserve Manager contract
   * @param _liquidityReserve Liquidity reserve address
   * @param _token Token address
   * @param _minAmount Minimum token amount
   */
  function setLiquidityReserveToken(address _liquidityReserve, address _token, uint256 _minAmount) external;

}