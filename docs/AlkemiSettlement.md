---
layout: default
title: Alkemi Settlement
nav_order: 4
---


# Alkemi Settlement

---
Alkemi Settlement Contract

---

## Contract Members
**Constants & Variables**

```js
//internal members
address internal constant ETH;

//public members
uint256 public oraclePrice;

```

## Functions

- [depositIntoLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount)](#depositintoliquidityreserve)
- [withdrawFromLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount)](#withdrawfromliquidityreserve)
- [approveTokenTransfer(address _liquidityReserve, address _token, uint256 _amount)](#approvetokentransfer)
- [priceOf(address _token)](#priceof)
- [incerementPriceOf(address _token, uint256 _increment)](#incerementpriceof)
- [decerementPriceOf(address _token, uint256 _decrement)](#decerementpriceof)
- [resetPriceOf(address _token, uint256 _price)](#resetpriceof)

### depositIntoLiquidityReserve

this is just a mock for testing purpose

```js
function depositIntoLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount) public payable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityReserve | address | liquidity reserve address |
| _token | address | erc20 token address to deposit |
| _amount | uint256 | amount to deposit |

### withdrawFromLiquidityReserve

this is just a mock for testing purpose

```js
function withdrawFromLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityReserve | address | liquidity reserve address |
| _token | address | erc20 token address to deposit |
| _amount | uint256 | amount to deposit |

### approveTokenTransfer

this is just a mock for testing purpose

```js
function approveTokenTransfer(address _liquidityReserve, address _token, uint256 _amount) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityReserve | address | liquidity reserve address |
| _token | address | erc20 token address to deposit |
| _amount | uint256 | amount to deposit |

### priceOf

this is just  mock for testing purpose

```js
function priceOf(address _token) external view
returns(uint256)
```

**Returns**

token price

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address | token address |

### incerementPriceOf

```js
function incerementPriceOf(address _token, uint256 _increment) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  |
| _increment | uint256 |  |

### decerementPriceOf

```js
function decerementPriceOf(address _token, uint256 _decrement) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  |
| _decrement | uint256 |  |

### resetPriceOf

```js
function resetPriceOf(address _token, uint256 _price) external nonpayable
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  |
| _price | uint256 |  |
