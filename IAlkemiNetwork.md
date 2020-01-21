---
layout: default
title: IAlkemiNetwork
---

# IAlkemiNetwork.sol

View Source: [contracts/interfaces/IAlkemiNetwork.sol](../contracts/interfaces/IAlkemiNetwork.sol)

**{{ContractName}}**

## Functions

- [currentSettlementId()](#currentsettlementid)
- [providerLiquidityReserves(address _liquidityProvider)](#providerliquidityreserves)
- [tokenLiquidityReserves(address _asset)](#tokenliquidityreserves)
- [doSettlement(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit)](#dosettlement)

### currentSettlementId

Get current settlement id

```js
function currentSettlementId() external view
returns(uint256)
```

**Returns**

settlement id

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### providerLiquidityReserves

Get liquidity reserves addresses of a liquidity provider

```js
function providerLiquidityReserves(address _liquidityProvider) external view
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
function tokenLiquidityReserves(address _asset) external view
returns(address[])
```

**Returns**

liquidity reserves addresses

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _asset | address | asset address | 

### doSettlement

settlement function

```js
function doSettlement(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit) external nonpayable
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| exchangesAddresses | address[] | list of exchanges addresses | 
| surplusTokensAddresses | address[] | list of surplus tokens | 
| deficitTokensAddresses | address[] | list of dificit tokens | 
| surplus | uint128[] | TokensAddresses list of surplus tokens | 
| deficit | uint128[] | TokensAddresses list of dificit tokens | 

