pragma solidity ^0.5.0;


/**
  * @title IAlkemiSettlement
  */
contract IAlkemiSettlement {

  /**
   * @dev deposit ERC20 or ETH into a specific liquidity reserve
   * @notice this is just a mock for testing purpose
   * @param _liquidityReserve liquidity reserve address
   * @param _token erc20 token address to deposit
   * @param _amount amount to deposit
   */
  function depositIntoLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount) external payable;

  /**
   * @dev withdraw ERC20 or ETH from a specific liquidity reserve
   * @notice this is just a mock for testing purpose
   * @param _liquidityReserve liquidity reserve address
   * @param _token erc20 token address to deposit
   * @param _amount amount to deposit
   */
  function withdrawFromLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount) public;
  /**
   * @dev approve liquidity reserve contract to transfer token from this contract
   * @notice this is just a mock for testing purpose
   * @param _liquidityReserve liquidity reserve address
   * @param _token erc20 token address to deposit
   * @param _amount amount to deposit
   */
  function approveTokenTransfer(address _liquidityReserve, address _token, uint256 _amount) external;

  /**
   * @dev settlement function
   * @param exchangesAddresses list of exchanges addresses
   * @param surplusTokensAddresses list of surplus tokens
   * @param deficitTokensAddresses list of dificit tokens
   * @param surplus list of surplus amount
   * @param deficit list of deficit
   */
  function doSettlement(
    address[] calldata exchangesAddresses,
    address[] calldata surplusTokensAddresses,
    address[] calldata deficitTokensAddresses,
    uint128[] calldata surplus,
    uint128[] calldata deficit
  ) external pure returns (bool); 

  /**
   * @dev Returns the price of specific token
   * @notice to-be-updated when developing the settlement contract
   * @param _token token address
   * @return token price
   */
  function priceOf(address _token) external view returns (uint256);

  /**
   * @dev Return the current settlement id
   */
  function settlementId() external view returns (uint256);
}