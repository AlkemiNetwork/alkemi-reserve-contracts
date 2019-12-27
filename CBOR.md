---
layout: default
title: CBOR
nav_order: 3
---

# CBOR.sol

View Source: [chainlinkv0.5/contracts/vendor/CBOR.sol](../chainlinkv0.5/contracts/vendor/CBOR.sol)

**{{ContractName}}**

## Contract Members
**Constants & Variables**

```js
uint8 private constant MAJOR_TYPE_INT;
uint8 private constant MAJOR_TYPE_NEGATIVE_INT;
uint8 private constant MAJOR_TYPE_BYTES;
uint8 private constant MAJOR_TYPE_STRING;
uint8 private constant MAJOR_TYPE_ARRAY;
uint8 private constant MAJOR_TYPE_MAP;
uint8 private constant MAJOR_TYPE_CONTENT_FREE;

```

## Functions

- [encodeType(struct Buffer.buffer buf, uint8 major, uint256 value)](#encodetype)
- [encodeIndefiniteLengthType(struct Buffer.buffer buf, uint8 major)](#encodeindefinitelengthtype)
- [encodeUInt(struct Buffer.buffer buf, uint256 value)](#encodeuint)
- [encodeInt(struct Buffer.buffer buf, int256 value)](#encodeint)
- [encodeBytes(struct Buffer.buffer buf, bytes value)](#encodebytes)
- [encodeString(struct Buffer.buffer buf, string value)](#encodestring)
- [startArray(struct Buffer.buffer buf)](#startarray)
- [startMap(struct Buffer.buffer buf)](#startmap)
- [endSequence(struct Buffer.buffer buf)](#endsequence)

### encodeType

```js
function encodeType(struct Buffer.buffer buf, uint8 major, uint256 value) private pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 
| major | uint8 |  | 
| value | uint256 |  | 

### encodeIndefiniteLengthType

```js
function encodeIndefiniteLengthType(struct Buffer.buffer buf, uint8 major) private pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 
| major | uint8 |  | 

### encodeUInt

```js
function encodeUInt(struct Buffer.buffer buf, uint256 value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 
| value | uint256 |  | 

### encodeInt

```js
function encodeInt(struct Buffer.buffer buf, int256 value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 
| value | int256 |  | 

### encodeBytes

```js
function encodeBytes(struct Buffer.buffer buf, bytes value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 
| value | bytes |  | 

### encodeString

```js
function encodeString(struct Buffer.buffer buf, string value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 
| value | string |  | 

### startArray

```js
function startArray(struct Buffer.buffer buf) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 

### startMap

```js
function startMap(struct Buffer.buffer buf) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 

### endSequence

```js
function endSequence(struct Buffer.buffer buf) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 

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
