pragma solidity ^0.5.0;

import "./factory/LiquidityReserveFactory.sol";
import "../interfaces/ILiquidityReserve.sol";


/**
 * @title LiquidityReserveManager
 * @dev This contract manages a specific Liquidity Reserve
 */
contract LiquidityReserveManager is  LiquidityReserveFactory{

  address public owner;

  mapping(address => address) private _liquidityReserves;

  constructor() public {
    _setOwner(msg.sender);
  }

  /**
   * @dev Verifies that the caller is the Owner
   */
  modifier onlyOwner() {
    require(msg.sender == owner, "LiquidityReserveFactory: Only owner may perform this operation");
    _;
  }

  /**
   * @dev Creates and initialises a new LiquidityReserve
   * @param _alkemiToken Alkemi token address
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   * @return Address of new Liquidity Reserve
   */
  function createLiquidityReserve(
    address _alkemiToken,
    address _beneficiary,
    uint256 _lockingPeriod,
    uint256 _lockingPrice,
    uint8 _lockingPricePosition
  ) public returns (address) {
    _liquidityReserves[msg.sender] = _createLiquidityReserve(
      msg.sender,
      address(this),
      _alkemiToken,
      _beneficiary,
      _lockingPeriod,
      _lockingPrice,
      _lockingPricePosition
    );
  }

  function liquidityReserveOf(address _liquidityProvider) public view returns (address) {
    return _liquidityReserves[_liquidityProvider];
  }

  /**
   * @dev Manager can set the address of the new Owner here
   * @param _owner Address of the new Owner
   */
  function setNewOwner(address _owner) public onlyOwner {
    _setOwner(_owner);
  }

  /**
   * @dev Set new Alkemi token for a specific liquidity reserve
   * @notice This function can only be called by the owner of the Liquidity Reserve Manager contract
   * @param _liquidityReserve Liquidity reserve address
   * @param _token Token address
   * @param _minAmount Minimum token amount
   */
  function setLiquidityReserveToken(address _liquidityReserve, address _token, uint256 _minAmount) public onlyOwner {
    _setLiquidityReserveToken(_liquidityReserve, _token, _minAmount);
  }

  function _setOwner(address _owner) internal {
    require(
      (_owner != address(0)) && (_owner != address(this)),
      "LiquidityReserveManager: invalid owner address"
    );

    owner = _owner;
  }

  function _setLiquidityReserveToken(address _liquidityReserve, address _token, uint256 _minAmount) internal {
    require(
      _liquidityReserve != address(0),
      "LiquidityReserveManager: invalid liquidity reserve address"
    );
    require(
      _token != address(0),
      "LiquidityReserveManager: invalid token address"
    );

    ILiquidityReserve(_liquidityReserve).setToken(_token, _minAmount);
  }
}