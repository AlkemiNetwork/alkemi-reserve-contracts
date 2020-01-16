---
layout: default
title: Buffer
---

# Buffer.sol

View Source: [chainlinkv0.5/contracts/vendor/Buffer.sol](../chainlinkv0.5/contracts/vendor/Buffer.sol)

**{{ContractName}}**

A library for working with mutable byte buffers in Solidity.
* Byte buffers are mutable and expandable, and provide a variety of primitives
for writing to them. At any time you can fetch a bytes object containing the
current contents of the buffer. The bytes object should not be stored between
operations, as it may change due to resizing of the buffer.

## Structs
### buffer

```js
struct buffer {
 bytes buf,
 uint256 capacity
}
```

## Functions

- [init(struct Buffer.buffer buf, uint256 capacity)](#init)
- [fromBytes(bytes b)](#frombytes)
- [resize(struct Buffer.buffer buf, uint256 capacity)](#resize)
- [max(uint256 a, uint256 b)](#max)
- [truncate(struct Buffer.buffer buf)](#truncate)
- [write(struct Buffer.buffer buf, uint256 off, bytes data, uint256 len)](#write)
- [append(struct Buffer.buffer buf, bytes data, uint256 len)](#append)
- [append(struct Buffer.buffer buf, bytes data)](#append)
- [writeUint8(struct Buffer.buffer buf, uint256 off, uint8 data)](#writeuint8)
- [appendUint8(struct Buffer.buffer buf, uint8 data)](#appenduint8)
- [write(struct Buffer.buffer buf, uint256 off, bytes32 data, uint256 len)](#write)
- [writeBytes20(struct Buffer.buffer buf, uint256 off, bytes20 data)](#writebytes20)
- [appendBytes20(struct Buffer.buffer buf, bytes20 data)](#appendbytes20)
- [appendBytes32(struct Buffer.buffer buf, bytes32 data)](#appendbytes32)
- [writeInt(struct Buffer.buffer buf, uint256 off, uint256 data, uint256 len)](#writeint)
- [appendInt(struct Buffer.buffer buf, uint256 data, uint256 len)](#appendint)

### init

Initializes a buffer with an initial capacity.

```js
function init(struct Buffer.buffer buf, uint256 capacity) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to initialize. | 
| capacity | uint256 | The number of bytes of space to allocate the buffer. | 

### fromBytes

Initializes a new buffer from an existing bytes object.
     Changes to the buffer may mutate the original value.

```js
function fromBytes(bytes b) internal pure
returns(struct Buffer.buffer)
```

**Returns**

A new buffer.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| b | bytes | The bytes object to initialize the buffer with. | 

### resize

```js
function resize(struct Buffer.buffer buf, uint256 capacity) private pure
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer |  | 
| capacity | uint256 |  | 

### max

```js
function max(uint256 a, uint256 b) private pure
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| a | uint256 |  | 
| b | uint256 |  | 

### truncate

Sets buffer length to 0.

```js
function truncate(struct Buffer.buffer buf) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining..

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to truncate. | 

### write

Writes a byte string to a buffer. Resizes if doing so would exceed
     the capacity of the buffer.

```js
function write(struct Buffer.buffer buf, uint256 off, bytes data, uint256 len) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| off | uint256 | The start offset to write to. | 
| data | bytes | The data to append. | 
| len | uint256 | The number of bytes to copy. | 

### append

Appends a byte string to a buffer. Resizes if doing so would exceed
     the capacity of the buffer.

```js
function append(struct Buffer.buffer buf, bytes data, uint256 len) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| data | bytes | The data to append. | 
| len | uint256 | The number of bytes to copy. | 

### append

Appends a byte string to a buffer. Resizes if doing so would exceed
     the capacity of the buffer.

```js
function append(struct Buffer.buffer buf, bytes data) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| data | bytes | The data to append. | 

### writeUint8

Writes a byte to the buffer. Resizes if doing so would exceed the
     capacity of the buffer.

```js
function writeUint8(struct Buffer.buffer buf, uint256 off, uint8 data) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| off | uint256 | The offset to write the byte at. | 
| data | uint8 | The data to append. | 

### appendUint8

Appends a byte to the buffer. Resizes if doing so would exceed the
     capacity of the buffer.

```js
function appendUint8(struct Buffer.buffer buf, uint8 data) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| data | uint8 | The data to append. | 

### write

Writes up to 32 bytes to the buffer. Resizes if doing so would
     exceed the capacity of the buffer.

```js
function write(struct Buffer.buffer buf, uint256 off, bytes32 data, uint256 len) private pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| off | uint256 | The offset to write at. | 
| data | bytes32 | The data to append. | 
| len | uint256 | The number of bytes to write (left-aligned). | 

### writeBytes20

Writes a bytes20 to the buffer. Resizes if doing so would exceed the
     capacity of the buffer.

```js
function writeBytes20(struct Buffer.buffer buf, uint256 off, bytes20 data) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| off | uint256 | The offset to write at. | 
| data | bytes20 | The data to append. | 

### appendBytes20

Appends a bytes20 to the buffer. Resizes if doing so would exceed
     the capacity of the buffer.

```js
function appendBytes20(struct Buffer.buffer buf, bytes20 data) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chhaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| data | bytes20 | The data to append. | 

### appendBytes32

Appends a bytes32 to the buffer. Resizes if doing so would exceed
     the capacity of the buffer.

```js
function appendBytes32(struct Buffer.buffer buf, bytes32 data) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| data | bytes32 | The data to append. | 

### writeInt

Writes an integer to the buffer. Resizes if doing so would exceed
     the capacity of the buffer.

```js
function writeInt(struct Buffer.buffer buf, uint256 off, uint256 data, uint256 len) private pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer, for chaining.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| off | uint256 | The offset to write at. | 
| data | uint256 | The data to append. | 
| len | uint256 | The number of bytes to write (right-aligned). | 

### appendInt

Appends a byte to the end of the buffer. Resizes if doing so would
exceed the capacity of the buffer.

```js
function appendInt(struct Buffer.buffer buf, uint256 data, uint256 len) internal pure
returns(struct Buffer.buffer)
```

**Returns**

The original buffer.

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| buf | struct Buffer.buffer | The buffer to append to. | 
| data | uint256 | The data to append. | 
| len | uint256 |  | 

