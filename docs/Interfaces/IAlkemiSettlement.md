---
layout: default
title: Alkemi Settlement (Interface)
nav_order: 1
has_children: true
---

# Alkemi Settlement (Interface)

View Source: [contracts/interfaces/IAlkemiSettlement.sol](../contracts/interfaces/IAlkemiSettlement.sol)

## Functions

- [depositIntoLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount)](#depositintoliquidityreserve)
- [withdrawFromLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount)](#withdrawfromliquidityreserve)
- [approveTokenTransfer(address _liquidityReserve, address _token, uint256 _amount)](#approvetokentransfer)
- [doSettlement(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit)](#dosettlement)
- [priceOf(address _token)](#priceof)
- [settlementId()](#settlementid)

### depositIntoLiquidityReserve

this is just a mock for testing purpose

```js
function depositIntoLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount) external payable
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
function approveTokenTransfer(address _liquidityReserve, address _token, uint256 _amount) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityReserve | address | liquidity reserve address | 
| _token | address | erc20 token address to deposit | 
| _amount | uint256 | amount to deposit | 

### doSettlement

settlement function

```js
function doSettlement(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit) external pure
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

### priceOf

to-be-updated when developing the settlement contract

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

### settlementId

Return the current settlement id

```js
function settlementId() external view
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

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
