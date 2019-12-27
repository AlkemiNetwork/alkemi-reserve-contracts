---
layout: default
title: AlkemiSettlementMock
nav_order: 3
---

# AlkemiSettlementMock.sol

View Source: [contracts/mocks/AlkemiSettlementMock.sol](../contracts/mocks/AlkemiSettlementMock.sol)

**{{ContractName}}**

Alkemi Settlement contract mock

## Contract Members
**Constants & Variables**

```js
//internal members
address internal constant ETH;

//public members
address public oracle;
uint256 public settlementId;
uint256 public oraclePrice;

```

## Functions

- [setOracleAddress(address _oracle)](#setoracleaddress)
- [depositIntoLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount)](#depositintoliquidityreserve)
- [withdrawFromLiquidityReserve(address _liquidityReserve, address _token, uint256 _amount)](#withdrawfromliquidityreserve)
- [approveTokenTransfer(address _liquidityReserve, address _token, uint256 _amount)](#approvetokentransfer)
- [doSettlement(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit)](#dosettlement)
- [RequestContinueTrading()](#requestcontinuetrading)
- [priceOf(address _token)](#priceof)
- [incerementPriceOf(address _token, uint256 _increment)](#incerementpriceof)
- [decerementPriceOf(address _token, uint256 _decrement)](#decerementpriceof)
- [resetPriceOf(address _token, uint256 _price)](#resetpriceof)

### setOracleAddress

```js
function setOracleAddress(address _oracle) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _oracle | address |  | 

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

### RequestContinueTrading

```js
function RequestContinueTrading() internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

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

## Contracts

* [Address](Address.md)
* [AlkemiNetwork](AlkemiNetwork.md)
* [AlkemiOracle](AlkemiOracle.md)
* [AlkemiSettlementMock](AlkemiSettlementMock.md)
* [Buffer](Buffer.md)
* [CBOR](CBOR.md)
* [Chainlink](Chainlink.md)
* [ChainlinkClient](ChainlinkClient.md)
* [ChainlinkOracle](ChainlinkOracle.md)
* [ChainlinkRequestInterface](ChainlinkRequestInterface.md)
* [Context](Context.md)
* [ENSInterface](ENSInterface.md)
* [ENSResolver](ENSResolver.md)
* [ERC20](ERC20.md)
* [ERC20Detailed](ERC20Detailed.md)
* [ERC20Mintable](ERC20Mintable.md)
* [EtherTokenConstantMock](EtherTokenConstantMock.md)
* [IAlkemiSettlement](IAlkemiSettlement.md)
* [IAlkemiToken](IAlkemiToken.md)
* [IERC20](IERC20.md)
* [ILiquidityReserve](ILiquidityReserve.md)
* [ILiquidityReserveFactory](ILiquidityReserveFactory.md)
* [IOracle](IOracle.md)
* [IOracleGuard](IOracleGuard.md)
* [LinkTokenInterface](LinkTokenInterface.md)
* [LinkTokenReceiver](LinkTokenReceiver.md)
* [LiquidityReserve](LiquidityReserve.md)
* [LiquidityReserveFactory](LiquidityReserveFactory.md)
* [LiquidityReserveState](LiquidityReserveState.md)
* [Migrations](Migrations.md)
* [MinterRole](MinterRole.md)
* [Oracle](Oracle.md)
* [OracleGuard](OracleGuard.md)
* [OracleInterface](OracleInterface.md)
* [Ownable](Ownable.md)
* [PointerInterface](PointerInterface.md)
* [Roles](Roles.md)
* [SafeERC20](SafeERC20.md)
* [SafeMath](SafeMath.md)
* [TokenMock](TokenMock.md)
