---
layout: default
title: AlkemiNetworkMock
---

# AlkemiNetworkMock (AlkemiNetworkMock.sol)

View Source: [contracts/mocks/AlkemiNetworkMock.sol](../contracts/mocks/AlkemiNetworkMock.sol)

**{{ContractName}}**

A contract to mock AlkemiNetwork functions

## Contract Members
**Constants & Variables**

```js
address public owner;
address public alkemiOracle;
uint256 public currentSettlementId;

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
- [doSettlement(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit)](#dosettlement)
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

### doSettlement

settlement function

```js
function doSettlement(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit) external nonpayable onlyAlkemiOracle 
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

