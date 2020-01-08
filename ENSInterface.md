---
layout: default
title: ENSInterface
nav_order: 3
---

# ENSInterface.sol

View Source: [chainlinkv0.5/contracts/interfaces/ENSInterface.sol](../chainlinkv0.5/contracts/interfaces/ENSInterface.sol)

**{{ContractName}}**

**Events**

```js
event NewOwner(bytes32 indexed node, bytes32 indexed label, address  owner);
event Transfer(bytes32 indexed node, address  owner);
event NewResolver(bytes32 indexed node, address  resolver);
event NewTTL(bytes32 indexed node, uint64  ttl);
```

## Functions

- [setSubnodeOwner(bytes32 node, bytes32 label, address _owner)](#setsubnodeowner)
- [setResolver(bytes32 node, address _resolver)](#setresolver)
- [setOwner(bytes32 node, address _owner)](#setowner)
- [setTTL(bytes32 node, uint64 _ttl)](#setttl)
- [owner(bytes32 node)](#owner)
- [resolver(bytes32 node)](#resolver)
- [ttl(bytes32 node)](#ttl)

### setSubnodeOwner

```js
function setSubnodeOwner(bytes32 node, bytes32 label, address _owner) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | bytes32 |  | 
| label | bytes32 |  | 
| _owner | address |  | 

### setResolver

```js
function setResolver(bytes32 node, address _resolver) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | bytes32 |  | 
| _resolver | address |  | 

### setOwner

```js
function setOwner(bytes32 node, address _owner) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | bytes32 |  | 
| _owner | address |  | 

### setTTL

```js
function setTTL(bytes32 node, uint64 _ttl) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | bytes32 |  | 
| _ttl | uint64 |  | 

### owner

```js
function owner(bytes32 node) external view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | bytes32 |  | 

### resolver

```js
function resolver(bytes32 node) external view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | bytes32 |  | 

### ttl

```js
function ttl(bytes32 node) external view
returns(uint64)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | bytes32 |  | 

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
