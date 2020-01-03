---
layout: default
title: LinkTokenInterface
nav_order: 3
---

# LinkTokenInterface.sol

View Source: [chainlinkv0.5/contracts/interfaces/LinkTokenInterface.sol](../chainlinkv0.5/contracts/interfaces/LinkTokenInterface.sol)

**{{ContractName}}**

## Functions

- [allowance(address owner, address spender)](#allowance)
- [approve(address spender, uint256 value)](#approve)
- [balanceOf(address owner)](#balanceof)
- [decimals()](#decimals)
- [decreaseApproval(address spender, uint256 addedValue)](#decreaseapproval)
- [increaseApproval(address spender, uint256 subtractedValue)](#increaseapproval)
- [name()](#name)
- [symbol()](#symbol)
- [totalSupply()](#totalsupply)
- [transfer(address to, uint256 value)](#transfer)
- [transferAndCall(address to, uint256 value, bytes data)](#transferandcall)
- [transferFrom(address from, address to, uint256 value)](#transferfrom)

### allowance

```js
function allowance(address owner, address spender) external nonpayable
returns(remaining uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| owner | address |  | 
| spender | address |  | 

### approve

```js
function approve(address spender, uint256 value) external nonpayable
returns(success bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| spender | address |  | 
| value | uint256 |  | 

### balanceOf

```js
function balanceOf(address owner) external nonpayable
returns(balance uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| owner | address |  | 

### decimals

```js
function decimals() external nonpayable
returns(decimalPlaces uint8)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### decreaseApproval

```js
function decreaseApproval(address spender, uint256 addedValue) external nonpayable
returns(success bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| spender | address |  | 
| addedValue | uint256 |  | 

### increaseApproval

```js
function increaseApproval(address spender, uint256 subtractedValue) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| spender | address |  | 
| subtractedValue | uint256 |  | 

### name

```js
function name() external nonpayable
returns(tokenName string)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### symbol

```js
function symbol() external nonpayable
returns(tokenSymbol string)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### totalSupply

```js
function totalSupply() external nonpayable
returns(totalTokensIssued uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### transfer

```js
function transfer(address to, uint256 value) external nonpayable
returns(success bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| to | address |  | 
| value | uint256 |  | 

### transferAndCall

```js
function transferAndCall(address to, uint256 value, bytes data) external nonpayable
returns(success bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| to | address |  | 
| value | uint256 |  | 
| data | bytes |  | 

### transferFrom

```js
function transferFrom(address from, address to, uint256 value) external nonpayable
returns(success bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| from | address |  | 
| to | address |  | 
| value | uint256 |  | 

## Contracts

* [Address](Address.md)
* [AlkemiNetwork](AlkemiNetwork.md)
* [AlkemiNetworkMock](AlkemiNetworkMock.md)
* [AlkemiOracle](AlkemiOracle.md)
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
* [IAlkemiNetwork](IAlkemiNetwork.md)
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
