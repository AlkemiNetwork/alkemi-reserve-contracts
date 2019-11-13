pragma solidity ^0.5.0;

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
  
}