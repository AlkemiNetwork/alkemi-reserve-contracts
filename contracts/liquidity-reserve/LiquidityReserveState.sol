pragma solidity ^0.5.0;

contract LiquidityReserveState {
  address private _alkemiNetwork;   // address of the LiquidityReserveManager contract
  address private _liquidityProvider;         // liqudity provider wallet address

  event LiquidityProviderChanged(
    address indexed previousProvider,
    address indexed newProvider
  );

  event settlementContractChanged(
    address indexed previousContract,
    address indexed newContract
  );


  /**
   * @dev Initializes the liquidity reserve state setting the Alkemi Network and the provider address.
   */
  constructor(address alkemiNetwork, address liquidityProvider) internal {
    require(alkemiNetwork != address(0), "LiquidityReserveState: invalid liquidity manager contract address");
    require(liquidityProvider != address(0), "LiquidityReserveState: invalid liquidity provider address");

    _alkemiNetwork = alkemiNetwork;
    _liquidityProvider = liquidityProvider;

    emit LiquidityProviderChanged(address(0), _liquidityProvider);
  }

  /**
   * @dev Returns the address of the current liquidity provider.
   */
  function liquidityProvider() public view returns (address) {
    return _liquidityProvider;
  }

  /**
   * @dev Returns the address of the Alkemi Network contract address.
   */
  function alkemiNetwork() public view returns (address) {
    return _alkemiNetwork;
  }

  /**
   * @dev Throws if called by any account other than the liquidity provider
   */
  modifier onlyPermissioned() {
    require(havePermission(), "LiquidityReserveState: caller does not have permission");
    _;
  }

  /**
   * @dev Returns true if the caller is the current liquidity provider
   */
  function havePermission() public view returns (bool) {
    return msg.sender == _liquidityProvider;
  }

  /**
   * @dev Throws if called by any account other than the liquidity provider.
   */
  modifier onlyLiquidityProvider() {
    require(isLiquidityprovider(), "LiquidityReserveState: caller is not the liquidity provider");
    _;
  }

  /**
   * @dev Returns true if the caller is the current liquidity provider.
   */
  function isLiquidityprovider() public view returns (bool) {
    return msg.sender == _liquidityProvider;
  }

  /**
   * @dev Throws if called by any account other than the Alkemi Network contract.
   */
  modifier onlyAlkemi() {
    require(isAlkemiNetwork(), "LiquidityReserveState: caller is not the Alkemi Network contract");
    _;
  }

  /**
   * @dev Returns true if the caller is Alkemi Network contract.
   */
  function isAlkemiNetwork() public view returns (bool) {
    return msg.sender == _alkemiNetwork;
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newLiquidityprovider`).
   * Can only be called by the current liquidity provider.
   */
  function transferLiquidityProvider(address newLiquidityprovider) public onlyLiquidityProvider {
    _transferLiquidityProvider(newLiquidityprovider);
  }

  /**
   * @dev Change liqudity provider to a new account (`newLiquidityprovider`).
   */
  function _transferLiquidityProvider(address newLiquidityprovider) internal {
    require(newLiquidityprovider != address(0), "Ownable: new owner is the zero address");

    emit LiquidityProviderChanged(_liquidityProvider, newLiquidityprovider);

    _liquidityProvider = newLiquidityprovider;
  }

}
