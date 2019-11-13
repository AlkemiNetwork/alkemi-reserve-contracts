pragma solidity ^0.5.0;

/**
 * @title LiquidityReserveManager
 * @dev This contract manages a specific Liquidity Reserve
 */
contract LiquidityReserveManager {

  address public manager;

  constructor() public {
    _setManager(_liquidityReserveManager);
  }

  /**
   * @dev Verifies that the caller is the Manager
   */
  modifier onlyManager() {
    require(msg.sender == manager, "LiquidityReserveFactory: Only manager may perform this operation");
    _;
  }

  /**
   * @dev Manager can set the address of the new Manager here
   * @param _manager Address of the new Manager
   */
  function setNewManager(address _liquidityReserveManager) public onlyManager {
    _setManager(_liquidityReserveManager);
  }

  function _setManager(address _liquidityReserveManager) internal {
    require(
      (_liquidityReserveManager != address(0)) && (_liquidityReserveManager != address(this)),
      "LiquidityReserveFactory: invalid manager address"
    );

    manager = _liquidityReserveManager;
  }
  
}