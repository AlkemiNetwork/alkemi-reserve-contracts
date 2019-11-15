pragma solidity ^0.5.0;

contract LiquidityReserveState {
  address private _liquidityReserveManager;   // address of the LiquidityReserveManager contract
  address private _settlementContract;        // address of the settlement contract
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
   * @dev Initializes the liquidity reserve state setting the provider and the settlement contract addresses.
   */
  constructor(address liquidityReserveManager, address settlementContract, address liquidityProvider) internal {
    require(liquidityReserveManager != address(0), "LiquidityReserveState: invalid liquidity manager contract address");
    require(settlementContract != address(0), "LiquidityReserveState: invalid settlement contract address");
    require(liquidityProvider != address(0), "LiquidityReserveState: invalid liquidity provider address");

    _liquidityReserveManager = liquidityReserveManager;
    _settlementContract = settlementContract;
    _liquidityProvider = liquidityProvider;

    emit settlementContractChanged(address(0), _settlementContract);
    emit LiquidityProviderChanged(address(0), _liquidityProvider);
  }

  /**
   * @dev Returns the address of the current liquidity provider.
   */
  function liquidityProvider() public view returns (address) {
    return _liquidityProvider;
  }

  /**
   * @dev Returns the address of the liquidity reserve manager contract.
   */
  function liquidityReserveManager() public view returns (address) {
    return _liquidityReserveManager;
  }

  /**
   * @dev Returns the address of the settlement contract.
   */
  function settlementContract() public view returns (address) {
    return _settlementContract;
  }

  /**
   * @dev Throws if called by any account other than the liquidity provider or settlement contract.
   */
  modifier onlyPermissioned() {
    require(havePermission(), "LiquidityReserveState: caller does not have permission");
    _;
  }

  /**
   * @dev Returns true if the caller is the current liquidity provider or the settlement contract.
   */
  function havePermission() public view returns (bool) {
    return ((msg.sender == _liquidityProvider) || (msg.sender == _settlementContract));
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
   * @dev Throws if called by any account other than the settlement contract.
   */
  modifier onlySettlementContract() {
    require(isSettlementContract(), "LiquidityReserveState: caller is not the settlement contract");
    _;
  }

  /**
   * @dev Returns true if the caller is the settlement contract.
   */
  function isSettlementContract() public view returns (bool) {
    return msg.sender == _settlementContract;
  }

  /**
   * @dev Throws if called by any account other than the liquidity reserve manager contract.
   */
  modifier onlyLiqudityReserveManager() {
    require(msg.sender == _liquidityReserveManager, "LiquidityReserve: caller is not the liquidity reserve manager contract");
    _;
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

    /**
   * @dev Change settlement contract address to a new address (`newSettlementContract`).
   * Can only be called by the liquidty reserve manager.
   */
  function transferSettlementContract(address newSettlementContract) public onlyLiqudityReserveManager {
    _transferSettlementContract(newSettlementContract);
  }

  /**
   * @dev Change settlement contract address to (`newLiquidityprovider`).
   */
  function _transferSettlementContract(address newSettlementContract) internal {
    require(newSettlementContract != address(0), "Ownable: new owner is the zero address");

    emit settlementContractChanged(_settlementContract, newSettlementContract);

    _settlementContract = newSettlementContract;
  }

}
