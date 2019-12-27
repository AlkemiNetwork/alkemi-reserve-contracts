---
layout: default
title: IOracleGuard
nav_order: 3
---

# IOracleGuard (IOracleGuard.sol)

View Source: [contracts/interfaces/IOracleGuard.sol](../contracts/interfaces/IOracleGuard.sol)

**{{ContractName}}**

## Functions

- [authNode(address[] a)](#authnode)
- [dropNode(address a)](#dropnode)
- [isContractAuth(address _contract)](#iscontractauth)
- [isNodeAuth(address _node)](#isnodeauth)
- [isNodeBan(address _node)](#isnodeban)
- [isNodeSlashed(address _node)](#isnodeslashed)
- [token()](#token)
- [requiredToken()](#requiredtoken)
- [nodesAvailable()](#nodesavailable)

### authNode

can only be called from an authorized sender

```js
function authNode(address[] a) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address[] | nodes addresses | 

### dropNode

can only be called from an authorized sender

```js
function dropNode(address a) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | address | node address | 

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
