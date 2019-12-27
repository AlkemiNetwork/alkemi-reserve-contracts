---
layout: default
title: Alkemi Network
nav_order: 3
---

# OracleGuard.sol

View Source: [contracts/oracles/OracleGuard.sol](../contracts/oracles/OracleGuard.sol)

**OracleGuard**

## Contract Members
**Constants & Variables**

```js
//internal members
address internal _oracleContract;
address internal _alkemiToken;
uint256 internal _requiredTokens;
uint256 internal _nodesCounter;

//public members
mapping(address => uint256) public auths;
mapping(address => uint256) public contracts;
mapping(address => uint256) public nodes;
mapping(uint256 => address) public slot;

```

## Modifiers

- [auth](#auth)

### auth

Allow only auth enticated sender

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
- [setTokenContract(address alkemiToken)](#settokencontract)
- [oracle()](#oracle)
- [token()](#token)
- [requiredToken()](#requiredtoken)
- [nodesAvailable()](#nodesavailable)

### 

```js
function (uint256 minimumTokens) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| minimumTokens | uint256 |  | 

### isContractAuth

Check if contract is authorized to call oracle

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

Check if node is authorized to submit book to oracle

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

can only be called from an authorized sender

```js
function rely(address usr, uint256 permission) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| usr | address | address | 
| permission | uint256 | Permission type | 

### deny

can only be called from an authorized sender

```js
function deny(address usr, uint256 permission) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| usr | address | address | 
| permission | uint256 | Permission type | 

### registerNode

Node can only be registered by Alkemi

```js
function registerNode(address[] a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address[] | node address | 

### authNode

can only be called from an authorized sender

```js
function authNode(address[] a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address[] | nodes addresses | 

### dropNode

can only be called from an authorized sender

```js
function dropNode(address a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address | node address | 

### authContract

can only be called from an authorized sender

```js
function authContract(address[] a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address[] | contracts addresseses | 

### dropContract

can only be called from an authorized sender

```js
function dropContract(address a) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address | contract address | 

### setOracleContract

can only be called from an authorized sender

```js
function setOracleContract(address oracleContract) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| oracleContract | address | oracle contract address | 

### setTokenContract

can only be called from an authorized sender

```js
function setTokenContract(address alkemiToken) external nonpayable auth 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| alkemiToken | address | Alkemi Token address | 

### oracle

Get on-chain oracle address

```js
function oracle() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### token

Get Alkemi Token address

```js
function token() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### requiredToken

Get the amount of required tokens to run node

```js
function requiredToken() public view
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### nodesAvailable

Get number of nodes available to vote

```js
function nodesAvailable() public view
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

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
