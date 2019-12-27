pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../interfaces/ILiquidityReserve.sol";
import "../interfaces/IOracle.sol";

/**
 * @notice Alkemi Settlement contract mock
 */
contract AlkemiSettlementMock {

  address internal constant ETH = address(0);
  address public oracle;

  uint256 public settlementId = 1;
  uint256 public oraclePrice = 200;

  function setOracleAddress(address _oracle) external {
    oracle = _oracle;
  }
    
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
   * @dev withdraw ERC20 or ETH from a specific liquidity reserve
   * @notice this is just a mock for testing purpose
   * @param _liquidityReserve liquidity reserve address
   * @param _token erc20 token address to deposit
   * @param _amount amount to deposit
   */
  function withdrawFromLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount) public {
    ILiquidityReserve(_liquidityReserve).withdraw(_token, _amount);
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
  ) external returns (bool) {
    return true;
  }

  function RequestContinueTrading() internal {
    IOracle(oracle).restartContainersTrading(settlementId, now);
  }

  /******************************* Mocking Oracle prices **********************************************************************/

  /**
   * @dev Returns the price of specific token
   * @notice this is just  mock for testing purpose
   * @param _token token address
   * @return token price
   */
  function priceOf(address _token) external view returns (uint256) {
    return oraclePrice ;
  }

  function incerementPriceOf(address _token, uint256 _increment) external {
    oraclePrice += _increment;
  }

  function decerementPriceOf(address _token, uint256 _decrement) external {
    oraclePrice -= _decrement;
  }

  function resetPriceOf(address _token, uint256 _price) external returns (uint256) {
    oraclePrice = _price;
    return oraclePrice;
  }

}
