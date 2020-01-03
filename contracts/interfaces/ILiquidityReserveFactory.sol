pragma solidity ^0.5.0;

/**
  * @title ILiquidityReserveFactory
  */
contract ILiquidityReserveFactory {
    /**
   * @dev Creates and initialises a new LiquidityReserve
   * @param _liquidityProvider Lequidity provider address
   * @param _alkemiNetwork Alkemi Network contract address
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   * @return Address of new Liquidity Reserve
   */
    function createLiquidityReserve(
        address _liquidityProvider,
        address _alkemiNetwork,
        address _beneficiary,
        address _asset,
        uint256 _lockingPeriod,
        uint256 _lockingPrice,
        uint8 _lockingPricePosition
    ) external returns (address);

}
