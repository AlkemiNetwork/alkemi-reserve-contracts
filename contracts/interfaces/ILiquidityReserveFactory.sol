pragma solidity ^0.5.0;


/**
  * @title ILiquidityReserveFactory
  */
contract ILiquidityReserveFactory {

  /**
   * @dev Creates and initialises a new LiquidityReserve
   * @param _liquidityReserveManager Lequidity Reserve Manager contract address
   * @param _alkemiToken Alkemi token address
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   * @return Address of new Liquidity Reserve
   */
  function createLiquidityReserve(
    address _liquidityReserveManager,
    address _alkemiToken,
    address _beneficiary,
    uint256 _lockingPeriod,
    uint256 _lockingPrice,
    uint8 _lockingPricePosition
  ) public returns (address);
}