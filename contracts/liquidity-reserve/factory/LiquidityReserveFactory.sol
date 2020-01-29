pragma solidity ^0.5.0;

import { LiquidityReserve } from "../LiquidityReserve.sol";

/**
 * @title LiquidityReserveFactory
 * @dev This Factory creates a Liquidity Reserve
 */
contract LiquidityReserveFactory {

  /**
   * @dev Creates and initialises a new LiquidityReserve
   * @param _linkToken LINK token address
   * @param _liquidityProvider Lequidity provider address
   * @param _alkemiNetwork Alkemi Network contract address
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _asset reserve asset
   * @param _createdAt reserve created time
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   * @return Address of new Liquidity Reserve
   */
  function _createLiquidityReserve(
    address _linkToken,
    address _liquidityProvider,
    address _alkemiNetwork,
    address _beneficiary,
    address _asset,
    uint256 _createdAt,
    uint256 _lockingPeriod,
    uint256 _lockingPrice,
    uint8 _lockingPricePosition
  ) internal returns (address) {
    return address(
      new LiquidityReserve(
        _linkToken,
        _liquidityProvider,
        _alkemiNetwork,
        _beneficiary,
        _asset,
        _createdAt,
        _lockingPeriod,
        _lockingPrice,
        _lockingPricePosition
      )
    );
  }
}