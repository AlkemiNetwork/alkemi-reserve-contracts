---
layout: default
title: ChainlinkClient
---

# The ChainlinkClient contract (ChainlinkClient.sol)

View Source: [chainlinkv0.5/contracts/ChainlinkClient.sol](../chainlinkv0.5/contracts/ChainlinkClient.sol)

**↘ Derived Contracts: [LiquidityReserve](LiquidityReserve.md)**

**{{ContractName}}**

Contract writers can inherit this contract in order to create requests for the
Chainlink network

## Contract Members
**Constants & Variables**

```js
//internal members
uint256 internal constant LINK;

//private members
uint256 private constant AMOUNT_OVERRIDE;
address private constant SENDER_OVERRIDE;
uint256 private constant ARGS_VERSION;
bytes32 private constant ENS_TOKEN_SUBNAME;
bytes32 private constant ENS_ORACLE_SUBNAME;
address private constant LINK_TOKEN_POINTER;
contract ENSInterface private ens;
bytes32 private ensNode;
contract LinkTokenInterface private link;
contract ChainlinkRequestInterface private oracle;
uint256 private requestCount;
mapping(bytes32 => address) private pendingRequests;

```

**Events**

```js
event ChainlinkRequested(bytes32 indexed id);
event ChainlinkFulfilled(bytes32 indexed id);
event ChainlinkCancelled(bytes32 indexed id);
```

## Modifiers

- [recordChainlinkFulfillment](#recordchainlinkfulfillment)
- [notPendingRequest](#notpendingrequest)

### recordChainlinkFulfillment

Reverts if the sender is not the oracle of the request.
Emits ChainlinkFulfilled event.

```js
modifier recordChainlinkFulfillment(bytes32 _requestId) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | The request ID for fulfillment | 

### notPendingRequest

Reverts if the request is already pending

```js
modifier notPendingRequest(bytes32 _requestId) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | The request ID for fulfillment | 

## Functions

- [buildChainlinkRequest(bytes32 _specId, address _callbackAddress, bytes4 _callbackFunctionSignature)](#buildchainlinkrequest)
- [sendChainlinkRequest(struct Chainlink.Request _req, uint256 _payment)](#sendchainlinkrequest)
- [sendChainlinkRequestTo(address _oracle, struct Chainlink.Request _req, uint256 _payment)](#sendchainlinkrequestto)
- [cancelChainlinkRequest(bytes32 _requestId, uint256 _payment, bytes4 _callbackFunc, uint256 _expiration)](#cancelchainlinkrequest)
- [setChainlinkOracle(address _oracle)](#setchainlinkoracle)
- [setChainlinkToken(address _link)](#setchainlinktoken)
- [setPublicChainlinkToken()](#setpublicchainlinktoken)
- [chainlinkTokenAddress()](#chainlinktokenaddress)
- [chainlinkOracleAddress()](#chainlinkoracleaddress)
- [addChainlinkExternalRequest(address _oracle, bytes32 _requestId)](#addchainlinkexternalrequest)
- [useChainlinkWithENS(address _ens, bytes32 _node)](#usechainlinkwithens)
- [updateChainlinkOracleWithENS()](#updatechainlinkoraclewithens)
- [encodeRequest(struct Chainlink.Request _req)](#encoderequest)
- [validateChainlinkCallback(bytes32 _requestId)](#validatechainlinkcallback)

### buildChainlinkRequest

Creates a request that can hold additional parameters

```js
function buildChainlinkRequest(bytes32 _specId, address _callbackAddress, bytes4 _callbackFunctionSignature) internal pure
returns(struct Chainlink.Request)
```

**Returns**

A Chainlink Request struct in memory

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _specId | bytes32 | The Job Specification ID that the request will be created for | 
| _callbackAddress | address | The callback address that the response will be sent to | 
| _callbackFunctionSignature | bytes4 | The callback function signature to use for the callback address | 

### sendChainlinkRequest

Creates a Chainlink request to the stored oracle address

```js
function sendChainlinkRequest(struct Chainlink.Request _req, uint256 _payment) internal nonpayable
returns(bytes32)
```

**Returns**

The request ID

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _req | struct Chainlink.Request | The initialized Chainlink Request | 
| _payment | uint256 | The amount of LINK to send for the request | 

### sendChainlinkRequestTo

Creates a Chainlink request to the specified oracle address

```js
function sendChainlinkRequestTo(address _oracle, struct Chainlink.Request _req, uint256 _payment) internal nonpayable
returns(requestId bytes32)
```

**Returns**

The request ID

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _oracle | address | The address of the oracle for the request | 
| _req | struct Chainlink.Request | The initialized Chainlink Request | 
| _payment | uint256 | The amount of LINK to send for the request | 

### cancelChainlinkRequest

Allows a request to be cancelled if it has not been fulfilled

```js
function cancelChainlinkRequest(bytes32 _requestId, uint256 _payment, bytes4 _callbackFunc, uint256 _expiration) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | The request ID | 
| _payment | uint256 | The amount of LINK sent for the request | 
| _callbackFunc | bytes4 | The callback function specified for the request | 
| _expiration | uint256 | The time of the expiration for the request | 

### setChainlinkOracle

Sets the stored oracle address

```js
function setChainlinkOracle(address _oracle) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _oracle | address | The address of the oracle contract | 

### setChainlinkToken

Sets the LINK token address

```js
function setChainlinkToken(address _link) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _link | address | The address of the LINK token contract | 

### setPublicChainlinkToken

Sets the Chainlink token address for the public
network as given by the Pointer contract

```js
function setPublicChainlinkToken() internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### chainlinkTokenAddress

Retrieves the stored address of the LINK token

```js
function chainlinkTokenAddress() internal view
returns(address)
```

**Returns**

The address of the LINK token

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### chainlinkOracleAddress

Retrieves the stored address of the oracle contract

```js
function chainlinkOracleAddress() internal view
returns(address)
```

**Returns**

The address of the oracle contract

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### addChainlinkExternalRequest

Allows for a request which was created on another contract to be fulfilled
on this contract

```js
function addChainlinkExternalRequest(address _oracle, bytes32 _requestId) internal nonpayable notPendingRequest 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _oracle | address | The address of the oracle contract that will fulfill the request | 
| _requestId | bytes32 | The request ID used for the response | 

### useChainlinkWithENS

Sets the stored oracle and LINK token contracts with the addresses resolved by ENS

```js
function useChainlinkWithENS(address _ens, bytes32 _node) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _ens | address | The address of the ENS contract | 
| _node | bytes32 | The ENS node hash | 

### updateChainlinkOracleWithENS

Sets the stored oracle contract with the address resolved by ENS

```js
function updateChainlinkOracleWithENS() internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### encodeRequest

Encodes the request to be sent to the oracle contract

```js
function encodeRequest(struct Chainlink.Request _req) private view
returns(bytes)
```

**Returns**

The bytes payload for the `transferAndCall` method

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _req | struct Chainlink.Request | The initialized Chainlink Request | 

### validateChainlinkCallback

Ensures that the fulfillment is valid for this contract

```js
function validateChainlinkCallback(bytes32 _requestId) internal nonpayable recordChainlinkFulfillment 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | The request ID for fulfillment | 

