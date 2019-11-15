pragma solidity ^0.5.0;


/**
  * @title ILiquidityReserveManager
  */
contract ILiquidityReserveManager {

  /**
   * @dev Creates and initialises a new LiquidityReserve
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   * @return Address of new Liquidity Reserve
   */
  function createLiquidityReserve(
    address _beneficiary,
    uint256 _lockingPeriod,
    uint256 _lockingPrice,
    uint8 _lockingPricePosition
  ) external;


  /**
   * @dev Get liquidity reserve address of a liquidity provider
   * @param _liquidityProvider liquidity provider address
   * @return liquidity reserve contract address
   */
  function liquidityReserveOf(address _liquidityProvider) public view returns (address);

  /**
   * @dev Manager can set the address of the new Owner here
   * @param _owner Address of the new Owner
   */
  function setNewOwner(address _owner) external;

}