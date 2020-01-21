---
layout: default
title: Oracle
nav_order: 3
---

# The Chainlink Oracle contract (Oracle.sol)

View Source: [chainlinkv0.5/contracts/Oracle.sol](../chainlinkv0.5/contracts/Oracle.sol)

**↗ Extends: [ChainlinkRequestInterface](ChainlinkRequestInterface.md), [OracleInterface](OracleInterface.md), [Ownable](Ownable.md), [LinkTokenReceiver](LinkTokenReceiver.md)**
**↘ Derived Contracts: [ChainlinkOracle](ChainlinkOracle.md)**

**{{ContractName}}**

Node operators can deploy this contract to fulfill requests sent to them

## Contract Members
**Constants & Variables**

```js
//public members
uint256 public constant EXPIRY_TIME;

//private members
uint256 private constant MINIMUM_CONSUMER_GAS_LIMIT;
uint256 private constant ONE_FOR_CONSISTENT_GAS_COST;
mapping(bytes32 => bytes32) private commitments;
mapping(address => bool) private authorizedNodes;
uint256 private withdrawableTokens;

//internal members
contract LinkTokenInterface internal LinkToken;

```

**Events**

```js
event OracleRequest(bytes32 indexed specId, address  requester, bytes32  requestId, uint256  payment, address  callbackAddr, bytes4  callbackFunctionId, uint256  cancelExpiration, uint256  dataVersion, bytes  data);
event CancelOracleRequest(bytes32 indexed requestId);
```

## Modifiers

- [hasAvailableFunds](#hasavailablefunds)
- [isValidRequest](#isvalidrequest)
- [onlyAuthorizedNode](#onlyauthorizednode)
- [checkCallbackAddress](#checkcallbackaddress)

### hasAvailableFunds

Reverts if amount requested is greater than withdrawable balance

```js
modifier hasAvailableFunds(uint256 _amount) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _amount | uint256 | The given amount to compare to `withdrawableTokens` | 

### isValidRequest

Reverts if request ID does not exist

```js
modifier isValidRequest(bytes32 _requestId) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | The given request ID to check in stored `commitments` | 

### onlyAuthorizedNode

Reverts if `msg.sender` is not authorized to fulfill requests

```js
modifier onlyAuthorizedNode() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### checkCallbackAddress

Reverts if the callback address is the LINK token

```js
modifier checkCallbackAddress(address _to) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _to | address | The callback address | 

## Functions

- [(address _link)](#)
- [oracleRequest(address _sender, uint256 _payment, bytes32 _specId, address _callbackAddress, bytes4 _callbackFunctionId, uint256 _nonce, uint256 _dataVersion, bytes _data)](#oraclerequest)
- [fulfillOracleRequest(bytes32 _requestId, uint256 _payment, address _callbackAddress, bytes4 _callbackFunctionId, uint256 _expiration, bytes32 _data)](#fulfilloraclerequest)
- [getAuthorizationStatus(address _node)](#getauthorizationstatus)
- [setFulfillmentPermission(address _node, bool _allowed)](#setfulfillmentpermission)
- [withdraw(address _recipient, uint256 _amount)](#withdraw)
- [withdrawable()](#withdrawable)
- [cancelOracleRequest(bytes32 _requestId, uint256 _payment, bytes4 _callbackFunc, uint256 _expiration)](#canceloraclerequest)
- [getChainlinkToken()](#getchainlinktoken)

### 

Deploy with the address of the LINK token

```js
function (address _link) public nonpayable Ownable 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _link | address | The address of the LINK token | 

### oracleRequest

⤾ overrides [ChainlinkRequestInterface.oracleRequest](ChainlinkRequestInterface.md#oraclerequest)

Creates the Chainlink request

```js
function oracleRequest(address _sender, uint256 _payment, bytes32 _specId, address _callbackAddress, bytes4 _callbackFunctionId, uint256 _nonce, uint256 _dataVersion, bytes _data) external nonpayable onlyLINK checkCallbackAddress 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _sender | address | The sender of the request | 
| _payment | uint256 | The amount of payment given (specified in wei) | 
| _specId | bytes32 | The Job Specification ID | 
| _callbackAddress | address | The callback address for the response | 
| _callbackFunctionId | bytes4 | The callback function ID for the response | 
| _nonce | uint256 | The nonce sent by the requester | 
| _dataVersion | uint256 | The specified data version | 
| _data | bytes | Version The specified data version | 

### fulfillOracleRequest

⤾ overrides [OracleInterface.fulfillOracleRequest](OracleInterface.md#fulfilloraclerequest)

Called by the Chainlink node to fulfill requests

```js
function fulfillOracleRequest(bytes32 _requestId, uint256 _payment, address _callbackAddress, bytes4 _callbackFunctionId, uint256 _expiration, bytes32 _data) external nonpayable onlyAuthorizedNode isValidRequest 
returns(bool)
```

**Returns**

Status if the external call was successful

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | The fulfillment request ID that must match the requester's | 
| _payment | uint256 | The payment amount that will be released for the oracle (specified in wei) | 
| _callbackAddress | address | The callback address to call for fulfillment | 
| _callbackFunctionId | bytes4 | The callback function ID to use for fulfillment | 
| _expiration | uint256 | The expiration that the node should respond by before the requester can cancel | 
| _data | bytes32 | The data to return to the consuming contract | 

### getAuthorizationStatus

⤾ overrides [OracleInterface.getAuthorizationStatus](OracleInterface.md#getauthorizationstatus)

Use this to check if a node is authorized for fulfilling requests

```js
function getAuthorizationStatus(address _node) external view
returns(bool)
```

**Returns**

The authorization status of the node

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _node | address | The address of the Chainlink node | 

### setFulfillmentPermission

⤾ overrides [OracleInterface.setFulfillmentPermission](OracleInterface.md#setfulfillmentpermission)

Sets the fulfillment permission for a given node. Use `true` to allow, `false` to disallow.

```js
function setFulfillmentPermission(address _node, bool _allowed) external nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _node | address | The address of the Chainlink node | 
| _allowed | bool | Bool value to determine if the node can fulfill requests | 

### withdraw

⤾ overrides [OracleInterface.withdraw](OracleInterface.md#withdraw)

Allows the node operator to withdraw earned LINK to a given address

```js
function withdraw(address _recipient, uint256 _amount) external nonpayable onlyOwner hasAvailableFunds 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _recipient | address | The address to send the LINK token to | 
| _amount | uint256 | The amount to send (specified in wei) | 

### withdrawable

⤾ overrides [OracleInterface.withdrawable](OracleInterface.md#withdrawable)

Displays the amount of LINK that is available for the node operator to withdraw

```js
function withdrawable() external view onlyOwner 
returns(uint256)
```

**Returns**

The amount of withdrawable LINK on the contract

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### cancelOracleRequest

⤾ overrides [ChainlinkRequestInterface.cancelOracleRequest](ChainlinkRequestInterface.md#canceloraclerequest)

Allows requesters to cancel requests sent to this oracle contract. Will transfer the LINK
sent for the request back to the requester's address.

```js
function cancelOracleRequest(bytes32 _requestId, uint256 _payment, bytes4 _callbackFunc, uint256 _expiration) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | The request ID | 
| _payment | uint256 | The amount of payment given (specified in wei) | 
| _callbackFunc | bytes4 | The requester's specified callback address | 
| _expiration | uint256 | The time of the expiration for the request | 

### getChainlinkToken

⤾ overrides [LinkTokenReceiver.getChainlinkToken](LinkTokenReceiver.md#getchainlinktoken)

Returns the address of the LINK token

```js
function getChainlinkToken() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Contracts

* [Address](Address.md)
* [AlkemiNetwork](AlkemiNetwork.md)
* [AlkemiNetworkMock](AlkemiNetworkMock.md)
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
* [IAlkemiNetwork](IAlkemiNetwork.md)
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
