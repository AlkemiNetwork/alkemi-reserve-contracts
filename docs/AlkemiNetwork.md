layout: default
title: Alkemi Networks
nav_order: 2

View Source: [contracts/AlkemiNetwork.sol](../contracts/AlkemiNetwork.sol)

**↗ Extends: [LiquidityReserveFactory](LiquidityReserveFactory.md)**

**AlkemiNetwork**

This contract manage Alkemi Network on-chain process

## Contract Members
**Constants & Variables**

```js
//public members
address public owner;

//internal members
mapping(address => address[]) internal _providerReserves;
mapping(address => address[]) internal _tokenReserves;

```

## Modifiers

- [onlyOwner](#onlyowner)

### onlyOwner

Verifies that the caller is the Owner

```js
modifier onlyOwner() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [()](#)
- [createLiquidityReserve(address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#createliquidityreserve)
- [providerLiquidityReserves(address _liquidityProvider)](#providerliquidityreserves)
- [tokenLiquidityReserves(address _asset)](#tokenliquidityreserves)
- [setNewOwner(address _owner)](#setnewowner)
- [_setOwner(address _owner)](#_setowner)

### 

```js
function () public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function createLiquidityReserve(address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) public nonpayable
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _asset | address | asset address | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

### providerLiquidityReserves

Get liquidity reserves addresses of a liquidity provider

```js
function providerLiquidityReserves(address _liquidityProvider) public view
returns(address[])
```

**Returns**

active liquidity reserve contract addresses

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityProvider | address | liquidity provider address | 

### tokenLiquidityReserves

Get liquidity reserves addresses that hold a specific asset

```js
function tokenLiquidityReserves(address _asset) public view
returns(address[])
```

**Returns**

liquidity reserves addresses

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _asset | address | asset address | 

### setNewOwner

Manager can set the address of the new Owner here

```js
function setNewOwner(address _owner) public nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _owner | address | Address of the new Owner | 

### _setOwner

```js
function _setOwner(address _owner) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _owner | address |  | 

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
