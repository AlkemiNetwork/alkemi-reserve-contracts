# LiquidityReserveState.sol

View Source: [contracts/liquidity-reserve/LiquidityReserveState.sol](../contracts/liquidity-reserve/LiquidityReserveState.sol)

**↘ Derived Contracts: [LiquidityReserve](LiquidityReserve.md)**

**LiquidityReserveState**

## Contract Members
**Constants & Variables**

```js
address private _liquidityReserveManager;
address private _settlementContract;
address private _liquidityProvider;

```

**Events**

```js
event LiquidityProviderChanged(address indexed previousProvider, address indexed newProvider);
event settlementContractChanged(address indexed previousContract, address indexed newContract);
```

## Modifiers

- [onlyPermissioned](#onlypermissioned)
- [onlyLiquidityProvider](#onlyliquidityprovider)
- [onlySettlementContract](#onlysettlementcontract)
- [onlyLiqudityReserveManager](#onlyliqudityreservemanager)

### onlyPermissioned

Throws if called by any account other than the liquidity provider or settlement contract.

```js
modifier onlyPermissioned() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### onlyLiquidityProvider

Throws if called by any account other than the liquidity provider.

```js
modifier onlyLiquidityProvider() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### onlySettlementContract

Throws if called by any account other than the settlement contract.

```js
modifier onlySettlementContract() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### onlyLiqudityReserveManager

Throws if called by any account other than the liquidity reserve manager contract.

```js
modifier onlyLiqudityReserveManager() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [(address liquidityReserveManager, address settlementContract, address liquidityProvider)](#)
- [liquidityProvider()](#liquidityprovider)
- [liquidityReserveManager()](#liquidityreservemanager)
- [settlementContract()](#settlementcontract)
- [havePermission()](#havepermission)
- [isLiquidityprovider()](#isliquidityprovider)
- [isSettlementContract()](#issettlementcontract)
- [transferLiquidityProvider(address newLiquidityprovider)](#transferliquidityprovider)
- [_transferLiquidityProvider(address newLiquidityprovider)](#_transferliquidityprovider)
- [transferSettlementContract(address newSettlementContract)](#transfersettlementcontract)
- [_transferSettlementContract(address newSettlementContract)](#_transfersettlementcontract)

### 

Initializes the liquidity reserve state setting the provider and the settlement contract addresses.

```js
function (address liquidityReserveManager, address settlementContract, address liquidityProvider) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| liquidityReserveManager | address |  | 
| settlementContract | address |  | 
| liquidityProvider | address |  | 

### liquidityProvider

Returns the address of the current liquidity provider.

```js
function liquidityProvider() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### liquidityReserveManager

Returns the address of the liquidity reserve manager contract.

```js
function liquidityReserveManager() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### settlementContract

Returns the address of the settlement contract.

```js
function settlementContract() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### havePermission

Returns true if the caller is the current liquidity provider or the settlement contract.

```js
function havePermission() public view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### isLiquidityprovider

Returns true if the caller is the current liquidity provider.

```js
function isLiquidityprovider() public view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### isSettlementContract

Returns true if the caller is the settlement contract.

```js
function isSettlementContract() public view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### transferLiquidityProvider

Transfers ownership of the contract to a new account (`newLiquidityprovider`).
Can only be called by the current liquidity provider.

```js
function transferLiquidityProvider(address newLiquidityprovider) public nonpayable onlyLiquidityProvider 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| newLiquidityprovider | address |  | 

### _transferLiquidityProvider

Change liqudity provider to a new account (`newLiquidityprovider`).

```js
function _transferLiquidityProvider(address newLiquidityprovider) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| newLiquidityprovider | address |  | 

### transferSettlementContract

Change settlement contract address to a new address (`newSettlementContract`).
Can only be called by the liquidty reserve manager.

```js
function transferSettlementContract(address newSettlementContract) public nonpayable onlyLiqudityReserveManager 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| newSettlementContract | address |  | 

### _transferSettlementContract

Change settlement contract address to (`newLiquidityprovider`).

```js
function _transferSettlementContract(address newSettlementContract) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| newSettlementContract | address |  | 

## Contracts

* [Address](Address.md)
* [AlkemiSettlement](AlkemiSettlement.md)
* [AlkemiSettlementMock](AlkemiSettlementMock.md)
* [Context](Context.md)
* [ERC20](ERC20.md)
* [ERC20Mintable](ERC20Mintable.md)
* [IAlkemiSettlement](IAlkemiSettlement.md)
* [IAlkemiToken](IAlkemiToken.md)
* [IERC20](IERC20.md)
* [ILiquidityReserve](ILiquidityReserve.md)
* [ILiquidityReserveManager](ILiquidityReserveManager.md)
* [IOracle](IOracle.md)
* [IOracleGuard](IOracleGuard.md)
* [LiquidityReserve](LiquidityReserve.md)
* [LiquidityReserveFactory](LiquidityReserveFactory.md)
* [LiquidityReserveManager](LiquidityReserveManager.md)
* [LiquidityReserveState](LiquidityReserveState.md)
* [Migrations](Migrations.md)
* [MinterRole](MinterRole.md)
* [Oracle](Oracle.md)
* [OracleGuard](OracleGuard.md)
* [Roles](Roles.md)
* [SafeERC20](SafeERC20.md)
* [SafeMath](SafeMath.md)
* [Token](Token.md)
* [TokenMock](TokenMock.md)
