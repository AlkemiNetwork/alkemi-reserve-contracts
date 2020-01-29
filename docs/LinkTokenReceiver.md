---
layout: default
title: LinkTokenReceiver
---

# LinkTokenReceiver.sol

View Source: [chainlinkv0.5/contracts/LinkTokenReceiver.sol](../chainlinkv0.5/contracts/LinkTokenReceiver.sol)

**↘ Derived Contracts: [Oracle](Oracle.md)**

**{{ContractName}}**

## Contract Members
**Constants & Variables**

```js
bytes4 private constant ORACLE_REQUEST_SELECTOR;
uint256 private constant SELECTOR_LENGTH;
uint256 private constant EXPECTED_REQUEST_WORDS;
uint256 private constant MINIMUM_REQUEST_LENGTH;

```

## Modifiers

- [onlyLINK](#onlylink)
- [permittedFunctionsForLINK](#permittedfunctionsforlink)
- [validRequestLength](#validrequestlength)

### onlyLINK

Reverts if not sent from the LINK token

```js
modifier onlyLINK() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### permittedFunctionsForLINK

Reverts if the given data does not begin with the `oracleRequest` function selector

```js
modifier permittedFunctionsForLINK(bytes _data) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _data | bytes | The data payload of the request | 

### validRequestLength

Reverts if the given payload is less than needed to create a request

```js
modifier validRequestLength(bytes _data) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _data | bytes | The request payload | 

## Functions

- [onTokenTransfer(address _sender, uint256 _amount, bytes _data)](#ontokentransfer)
- [getChainlinkToken()](#getchainlinktoken)

### onTokenTransfer

Called when LINK is sent to the contract via `transferAndCall`

```js
function onTokenTransfer(address _sender, uint256 _amount, bytes _data) public nonpayable onlyLINK validRequestLength permittedFunctionsForLINK 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _sender | address | Address of the sender | 
| _amount | uint256 | Amount of LINK sent (specified in wei) | 
| _data | bytes | Payload of the transaction | 

### getChainlinkToken

⤿ Overridden Implementation(s): [Oracle.getChainlinkToken](Oracle.md#getchainlinktoken)

```js
function getChainlinkToken() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

