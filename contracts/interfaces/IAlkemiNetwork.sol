pragma solidity ^0.5.0;

interface IAlkemiNetwork {
    /**
   * @notice Get current settlement id
   * @return settlement id
   */
    function currentSettlementId() external view returns (uint256);

    /**
   * @notice Get liquidity reserves addresses of a liquidity provider
   * @param _liquidityProvider liquidity provider address
   * @return active liquidity reserve contract addresses
   */
    function providerLiquidityReserves(address _liquidityProvider)
        external
        view
        returns (address[] memory);

    /**
   * @notice Get liquidity reserves addresses that hold a specific asset
   * @param _asset asset address
   * @return liquidity reserves addresses
   */
    function tokenLiquidityReserves(address _asset)
        external
        view
        returns (address[] memory);

    /**
   * @notice settlement function
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
    ) external returns (bool);
}
