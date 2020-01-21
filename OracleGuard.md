---
layout: default
title: OracleGuard
---

# OracleGuard.sol

View Source: [contracts/oracles/OracleGuard.sol](../contracts/oracles/OracleGuard.sol)

**{{ContractName}}**

## Contract Members
**Constants & Variables**

```js
address public alkemiOracle;
address public alkemiToken;
uint256 public requiredTokens;
uint256 public nodesCounter;
mapping(address => uint256) public auths;
mapping(address => uint256) public contracts;
mapping(address => uint256) public nodes;
mapping(uint256 => address) public slot;

```

## Modifiers

- [auth](#auth)

### auth

Allow only authenticated sender

```js
modifier auth(uint256 permission) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| permission | uint256 |  | 

## Functions

- [(uint256 minimumTokens)](#)
- [isContractAuth(address _contract)](#iscontractauth)
- [isNodeAuth(address _node)](#isnodeauth)
- [isNodeBan(address _node)](#isnodeban)
- [isNodeSlashed(address _node)](#isnodeslashed)
- [rely(address usr, uint256 permission)](#rely)
- [deny(address usr, uint256 permission)](#deny)
- [registerNode(address[] a)](#registernode)
- [authNode(address[] a)](#authnode)
- [dropNode(address a)](#dropnode)
- [authContract(address[] a)](#authcontract)
- [dropContract(address a)](#dropcontract)
- [setOracleContract(address oracleContract)](#setoraclecontract)
- [setTokenContract(address _alkemiToken)](#settokencontract)

### 

constructor

```js
function (uint256 minimumTokens) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| minimumTokens | uint256 | required Alkemi Token for nodes to submit book | 

### isContractAuth

Check if contract is authorized to call Alkemi Oracle

```js
function isContractAuth(address _contract) external view
returns(bool)
```

**Returns**

true if authorized

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _contract | address | contract address | 

### isNodeAuth

Check if node is authorized to submit book to Alkemi Oracle

```js
function isNodeAuth(address _node) external view
returns(bool)
```

**Returns**

true if authorized

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _node | address | node address | 

### isNodeBan

check if node is banned

```js
function isNodeBan(address _node) external view
returns(bool)
```

**Returns**

true if banned

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _node | address | node address | 

### isNodeSlashed

check if node is slashed (node does not have minimum token amount)

```js
function isNodeSlashed(address _node) external view
returns(bool)
```

**Returns**

true if banned

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _node | address | node address | 

### rely

Grant to an address permission

```js
function rely(address usr, uint256 permission) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| usr | address | address | 
| permission | uint256 | Permission type | 

### deny

Remove from an address OracleGuard Owner permission

```js
function deny(address usr, uint256 permission) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| usr | address | address | 
| permission | uint256 | Permission type | 

### registerNode

Register node

```js
function registerNode(address[] a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address[] | node address | 

### authNode

Auth node to call oracle

```js
function authNode(address[] a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address[] | nodes addresses | 

### dropNode

Ban node

```js
function dropNode(address a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address | node address | 

### authContract

Auth contracts to call oracle

```js
function authContract(address[] a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address[] | contracts addresseses | 

### dropContract

Ban contract

```js
function dropContract(address a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address | contract address | 

### setOracleContract

Set on-chain oracle address

```js
function setOracleContract(address oracleContract) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| oracleContract | address | oracle contract address | 

### setTokenContract

Set Alkemi Token address

```js
function setTokenContract(address _alkemiToken) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _alkemiToken | address | Alkemi Token address | 

