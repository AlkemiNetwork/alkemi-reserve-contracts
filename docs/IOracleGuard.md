---
layout: default
title: Oracle Guard (Interface)
nav_order: 8
parent: Interfaces
---

# Oracle Guard (Interface)

---

View Source: [contracts/interfaces/IOracleGuard.sol](https://github.com/project-alkemi/alkemi-protocol/blob/master/contracts/interfaces/IOracleGuard.sol)

---

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
