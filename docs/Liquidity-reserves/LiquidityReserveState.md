---
layout: default
title: Liquidity Reserve State
nav_order: 4
parent: Liquidity Reserve
---

# Liquidity Reserve State

View Source: [contracts/liquidity-reserve/LiquidityReserveState.sol](../contracts/liquidity-reserve/LiquidityReserveState.sol)

**↘ Derived Contracts: [Liquidity Reserve](LiquidityReserve.md)**


## Contract Members
**Constants & Variables**

```js
address private _alkemiNetwork;
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
- [onlyAlkemi](#onlyalkemi)

### onlyPermissioned

Throws if called by any account other than the liquidity provider

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

### onlyAlkemi

Throws if called by any account other than the Alkemi Network contract.

```js
modifier onlyAlkemi() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [(address alkemiNetwork, address liquidityProvider)](#)
- [liquidityProvider()](#liquidityprovider)
- [alkemiNetwork()](#alkeminetwork)
- [havePermission()](#havepermission)
- [isLiquidityprovider()](#isliquidityprovider)
- [isAlkemiNetwork()](#isalkeminetwork)
- [transferLiquidityProvider(address newLiquidityprovider)](#transferliquidityprovider)
- [_transferLiquidityProvider(address newLiquidityprovider)](#_transferliquidityprovider)

###

Initializes the liquidity reserve state setting the Alkemi Network and the provider address.

```js
function (address alkemiNetwork, address liquidityProvider) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| alkemiNetwork | address |  |
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

### alkemiNetwork

Returns the address of the Alkemi Network contract address.

```js
function alkemiNetwork() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### havePermission

Returns true if the caller is the current liquidity provider

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

### isAlkemiNetwork

Returns true if the caller is Alkemi Network contract.

```js
function isAlkemiNetwork() public view
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

## Contracts

* [Address](Address.md)
* [AlkemiNetwork](AlkemiNetwork.md)
* [AlkemiSettlement](AlkemiSettlement.md)
* [AlkemiSettlementMock](AlkemiSettlementMock.md)
* [Context](Context.md)
* [ERC20](ERC20.md)
* [ERC20Mintable](ERC20Mintable.md)
* [EtherTokenConstantMock](EtherTokenConstantMock.md)
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
