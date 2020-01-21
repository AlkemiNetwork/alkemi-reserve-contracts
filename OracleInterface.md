---
layout: default
title: OracleInterface
---

# OracleInterface.sol

View Source: [chainlinkv0.5/contracts/interfaces/OracleInterface.sol](../chainlinkv0.5/contracts/interfaces/OracleInterface.sol)

**↘ Derived Contracts: [Oracle](Oracle.md)**

**{{ContractName}}**

## Functions

- [fulfillOracleRequest(bytes32 requestId, uint256 payment, address callbackAddress, bytes4 callbackFunctionId, uint256 expiration, bytes32 data)](#fulfilloraclerequest)
- [getAuthorizationStatus(address node)](#getauthorizationstatus)
- [setFulfillmentPermission(address node, bool allowed)](#setfulfillmentpermission)
- [withdraw(address recipient, uint256 amount)](#withdraw)
- [withdrawable()](#withdrawable)

### fulfillOracleRequest

⤿ Overridden Implementation(s): [Oracle.fulfillOracleRequest](Oracle.md#fulfilloraclerequest)

```js
function fulfillOracleRequest(bytes32 requestId, uint256 payment, address callbackAddress, bytes4 callbackFunctionId, uint256 expiration, bytes32 data) external nonpayable
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| requestId | bytes32 |  | 
| payment | uint256 |  | 
| callbackAddress | address |  | 
| callbackFunctionId | bytes4 |  | 
| expiration | uint256 |  | 
| data | bytes32 |  | 

### getAuthorizationStatus

⤿ Overridden Implementation(s): [Oracle.getAuthorizationStatus](Oracle.md#getauthorizationstatus)

```js
function getAuthorizationStatus(address node) external view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | address |  | 

### setFulfillmentPermission

⤿ Overridden Implementation(s): [Oracle.setFulfillmentPermission](Oracle.md#setfulfillmentpermission)

```js
function setFulfillmentPermission(address node, bool allowed) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| node | address |  | 
| allowed | bool |  | 

### withdraw

⤿ Overridden Implementation(s): [Oracle.withdraw](Oracle.md#withdraw)

```js
function withdraw(address recipient, uint256 amount) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| recipient | address |  | 
| amount | uint256 |  | 

### withdrawable

⤿ Overridden Implementation(s): [Oracle.withdrawable](Oracle.md#withdrawable)

```js
function withdrawable() external view
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

