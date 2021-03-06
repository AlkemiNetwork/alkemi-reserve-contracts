---
layout: default
title: Chainlink
---

# Library for common Chainlink functions (Chainlink.sol)

View Source: [chainlinkv0.5/contracts/Chainlink.sol](../chainlinkv0.5/contracts/Chainlink.sol)

**{{ContractName}}**

Uses imported CBOR library for encoding to buffer

## Structs
### Request

```js
struct Request {
 bytes32 id,
 address callbackAddress,
 bytes4 callbackFunctionId,
 uint256 nonce,
 struct Buffer.buffer buf
}
```

## Contract Members
**Constants & Variables**

```js
uint256 internal constant defaultBufferSize;

```

## Functions

- [initialize(struct Chainlink.Request self, bytes32 _id, address _callbackAddress, bytes4 _callbackFunction)](#initialize)
- [setBuffer(struct Chainlink.Request self, bytes _data)](#setbuffer)
- [add(struct Chainlink.Request self, string _key, string _value)](#add)
- [addBytes(struct Chainlink.Request self, string _key, bytes _value)](#addbytes)
- [addInt(struct Chainlink.Request self, string _key, int256 _value)](#addint)
- [addUint(struct Chainlink.Request self, string _key, uint256 _value)](#adduint)
- [addStringArray(struct Chainlink.Request self, string _key, string[] _values)](#addstringarray)

### initialize

Initializes a Chainlink request

```js
function initialize(struct Chainlink.Request self, bytes32 _id, address _callbackAddress, bytes4 _callbackFunction) internal pure
returns(struct Chainlink.Request)
```

**Returns**

The initialized request

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| self | struct Chainlink.Request | The uninitialized request | 
| _id | bytes32 | The Job Specification ID | 
| _callbackAddress | address | The callback address | 
| _callbackFunction | bytes4 | The callback function signature | 

### setBuffer

Sets the data for the buffer without encoding CBOR on-chain

```js
function setBuffer(struct Chainlink.Request self, bytes _data) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| self | struct Chainlink.Request | The initialized request | 
| _data | bytes | The CBOR data | 

### add

Adds a string value to the request with a given key name

```js
function add(struct Chainlink.Request self, string _key, string _value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| self | struct Chainlink.Request | The initialized request | 
| _key | string | The name of the key | 
| _value | string | The string value to add | 

### addBytes

Adds a bytes value to the request with a given key name

```js
function addBytes(struct Chainlink.Request self, string _key, bytes _value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| self | struct Chainlink.Request | The initialized request | 
| _key | string | The name of the key | 
| _value | bytes | The bytes value to add | 

### addInt

Adds a int256 value to the request with a given key name

```js
function addInt(struct Chainlink.Request self, string _key, int256 _value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| self | struct Chainlink.Request | The initialized request | 
| _key | string | The name of the key | 
| _value | int256 | The int256 value to add | 

### addUint

Adds a uint256 value to the request with a given key name

```js
function addUint(struct Chainlink.Request self, string _key, uint256 _value) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| self | struct Chainlink.Request | The initialized request | 
| _key | string | The name of the key | 
| _value | uint256 | The uint256 value to add | 

### addStringArray

Adds an array of strings to the request with a given key name

```js
function addStringArray(struct Chainlink.Request self, string _key, string[] _values) internal pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| self | struct Chainlink.Request | The initialized request | 
| _key | string | The name of the key | 
| _values | string[] | The array of string values to add | 

