pragma solidity ^0.5.0;

import "./interfaces/ILiquidityReserve.sol";
import "./liquidity-reserve/factory/LiquidityReserveFactory.sol";

/**
 * @title AlkemiNetwork
 * @dev This contract manage Alkemi Network on-chain process
 */
contract AlkemiNetwork is LiquidityReserveFactory {
  address public owner;

  mapping(address => address[]) public providerReserves;
  mapping(address => address[]) public tokenReserves;

  event ReserveCreate(
    address indexed reserve,
    address indexed liquidityProvider,
    address indexed beneficiary,
    uint256 lockingPeriod,
    uint256 lockingPrice,
    uint8 lockingPricePosition
  );

  constructor() public {
    _setOwner(msg.sender);
  }

  /**
   * @dev Verifies that the caller is the Owner
   */
  modifier onlyOwner() {
    require(
      msg.sender == owner,
      "LiquidityReserveFactory: Only owner may perform this operation"
    );
    _;
  }

  /**
   * @dev Creates and initialises a new LiquidityReserve
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _asset asset address
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   * @return Address of new Liquidity Reserve
   */
  function createLiquidityReserve(
    address _linkToken,
    address _beneficiary,
    address _asset,
    uint256 _lockingPeriod,
    uint256 _lockingPrice,
    uint8 _lockingPricePosition
  ) public returns (address) {
    address r = _createLiquidityReserve(
      _linkToken,
      msg.sender,
      address(this),
      _beneficiary,
      _asset,
      _lockingPeriod,
      _lockingPrice,
      _lockingPricePosition
    );

    providerReserves[msg.sender].push(r);
    tokenReserves[_asset].push(r);

    emit ReserveCreate(
      r,
      msg.sender,
      _beneficiary,
      _lockingPeriod,
      _lockingPrice,
      _lockingPricePosition
    );
  }

  /**
   * @dev Get liquidity reserves addresses of a liquidity provider
   * @param _liquidityProvider liquidity provider address
   * @return active liquidity reserve contract addresses
   */
  function providerLiquidityReserves(address _liquidityProvider)
    public
    view
    returns (address[] memory)
  {
    address[] memory _reserves = providerReserves[_liquidityProvider];
    address[] memory _activeReserves = new address[](_reserves.length);

    uint256 j = 0;
    for (uint256 i = 0; i < _reserves.length; i++) {
      if (ILiquidityReserve(_reserves[i]).isActive()) {
        _activeReserves[j] = _reserves[i];
        j++;
      }
    }
    return _activeReserves;
  }

  /**
   * @dev Get liquidity reserves addresses that hold a specific asset
   * @param _asset asset address
   * @return liquidity reserves addresses
   */
  function tokenLiquidityReserves(address _asset)
    public
    view
    returns (address[] memory)
  {
    address[] memory _reserves = tokenReserves[_asset];
    address[] memory _activeReserves = new address[](_reserves.length);

    uint256 j = 0;
    for (uint256 i = 0; i < _reserves.length; i++) {
      if (ILiquidityReserve(_reserves[i]).isActive()) {
        _activeReserves[i] = _reserves[i];
        j++;
      }
    }
    return _activeReserves;
  }

  /**
   * @dev Manager can set the address of the new Owner here
   * @param _owner Address of the new Owner
   */
  function setNewOwner(address _owner) public onlyOwner {
    _setOwner(_owner);
  }

  function _setOwner(address _owner) internal {
    require(
      (_owner != address(0)) && (_owner != address(this)),
      "LiquidityReserveManager: invalid owner address"
    );

    owner = _owner;
  }

  /// Will be moved to the settlement contract
  /*
  function setLiquidityReserveToken(address _liquidityReserve, address _token, uint256 _minAmount) public onlyOwner {
    _setLiquidityReserveToken(_liquidityReserve, _token, _minAmount);
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
  */

}
