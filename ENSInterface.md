---
layout: default
title: ENSInterface
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

