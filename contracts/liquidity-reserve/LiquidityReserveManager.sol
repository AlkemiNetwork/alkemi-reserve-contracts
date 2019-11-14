pragma solidity ^0.5.0;

import "../interfaces/ILiquidityReserve.sol";

/**
 * @title LiquidityReserveManager
 * @dev This contract manages a specific Liquidity Reserve
 */
contract LiquidityReserveManager {

  address public owner;

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