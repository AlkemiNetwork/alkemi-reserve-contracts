pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../interfaces/ILiquidityReserve.sol";

/**
 * @notice Alkemi Settlement contract mock
 */
contract AlkemiSettlement {

  address internal constant ETH = address(0);
    
  /**
   * @dev deposit ERC20 or ETH into a specific liquidity reserve
   * @notice this is just a mock for testing purpose
   * @param _liquidityReserve liquidity reserve address
   * @param _token erc20 token address to deposit
   * @param _amount amount to deposit
   */
  function depositIntoLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount) public payable {
    ILiquidityReserve(_liquidityReserve).deposit(_token, _amount);
  }

  /**
   * @dev approve liquidity reserve contract to transfer token from this contract
   * @notice this is just a mock for testing purpose
   * @param _liquidityReserve liquidity reserve address
   * @param _token erc20 token address to deposit
   * @param _amount amount to deposit
   */
  function approveTokenTransfer(address _liquidityReserve, address _token, uint256 _amount) public {
    ERC20(_token).approve(_liquidityReserve, _amount);
  }

  /**
   * @dev Returns the price of specific token
   * @notice this is just  mock for testing purpose
   * @param _token token address
   * @return token price
   */
  function priceOf(address _token) external pure returns (uint256) {
    return 200;
  }

}
