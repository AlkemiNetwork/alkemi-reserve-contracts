---
layout: default
title: AlkemiNetwork
---

# AlkemiNetwork (AlkemiNetwork.sol)

View Source: [contracts/AlkemiNetwork.sol](../contracts/AlkemiNetwork.sol)

**↗ Extends: [LiquidityReserveFactory](LiquidityReserveFactory.md)**

**{{ContractName}}**

This contract manage Alkemi Network on-chain process

## Contract Members
**Constants & Variables**

```js
address public owner;
address public alkemiOracle;
mapping(address => address[]) public providerReserves;
mapping(address => address[]) public tokenReserves;
uint256 public currentSettlementId;

```

**Events**

```js
event ReserveCreate(address indexed reserve, address indexed liquidityProvider, address indexed beneficiary, uint256  lockingPeriod, uint256  lockingPrice, uint8  lockingPricePosition);
```

## Modifiers

- [onlyOwner](#onlyowner)
- [onlyAlkemiOracle](#onlyalkemioracle)

### onlyOwner

Verifies that the caller is the Owner

```js
modifier onlyOwner() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### onlyAlkemiOracle

Verifies that the calles is Alkemi Oracle

```js
modifier onlyAlkemiOracle() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [()](#)
- [providerLiquidityReserves(address _liquidityProvider)](#providerliquidityreserves)
- [providerTokenReserves(address _liquidityProvider, address _asset)](#providertokenreserves)
- [tokenLiquidityReserves(address _asset)](#tokenliquidityreserves)
- [createLiquidityReserve(address _linkToken, address _beneficiary, address _asset, uint256 _createdAt, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#createliquidityreserve)
- [setNewOwner(address _owner)](#setnewowner)
- [setAlkemiOracle(address _oracle)](#setalkemioracle)
- [_setOwner(address _owner)](#_setowner)
- [_setAlkemiOracle(address _oracle)](#_setalkemioracle)

### 

```js
function () public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

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

### providerTokenReserves

Get liquidity reserves addresses of a liquidity provider that hold specific asset

```js
function providerTokenReserves(address _liquidityProvider, address _asset) public view
returns(address[])
```

**Returns**

active liquidity reserve contract addresses

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityProvider | address | liquidity provider address | 
| _asset | address | asset address | 

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

### createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function createLiquidityReserve(address _linkToken, address _beneficiary, address _asset, uint256 _createdAt, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) public nonpayable
returns(address)
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _linkToken | address |  | 
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _asset | address | asset address | 
| _createdAt | uint256 |  | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

### setNewOwner

Set new owner address

```js
function setNewOwner(address _owner) public nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _owner | address | Address of the new Owner | 

### setAlkemiOracle

Set Alkemi Oracle address

```js
function setAlkemiOracle(address _oracle) public nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _oracle | address | oracle address | 

### _setOwner

```js
function _setOwner(address _owner) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _owner | address |  | 

### _setAlkemiOracle

```js
function _setAlkemiOracle(address _oracle) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _oracle | address |  | 

