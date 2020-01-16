---
layout: default
title: LiquidityReserve
---

# LiquidityReserve (LiquidityReserve.sol)

View Source: [contracts/liquidity-reserve/LiquidityReserve.sol](../contracts/liquidity-reserve/LiquidityReserve.sol)

**↗ Extends: [ChainlinkClient](ChainlinkClient.md), [LiquidityReserveState](LiquidityReserveState.md)**

**{{ContractName}}**

Base layer functionality for the Liquidity Reserve

**Enums**
### PriceLockout

```js
enum PriceLockout {
 BELOW,
 ABOVE
}
```

## Contract Members
**Constants & Variables**

```js
//internal members
address internal constant ETH;
uint256 internal _amountToWithdraw;

//public members
address public asset;
address public beneficiary;
uint256 public lockingPeriod;
uint256 public lockingPrice;
uint256 public totalBalance;
uint256 public deposited;
uint256 public earned;
uint256 public oraclePrice;
uint256 public lastPriceCheck;
uint8 public lockingPricePosition;
bool public isDepositable;

```

**Events**

```js
event ReserveDeposit(address indexed token, address indexed sender, uint256  amount);
event ReserveWithdraw(address indexed token, address indexed withdrawer, uint256  amount);
event ReserveApprove(address indexed token, address indexed to, uint256  amount);
event ReserveTransfer(address indexed token, address indexed to, uint256  amount);
event PriceUnlock(uint256  lockingPrice, uint256  oraclePrice, uint256  lockingPricePosition);
```

## Functions

- [(address _link, address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#)
- [isActive()](#isactive)
- [balance(address _token)](#balance)
- [isBeneficiary()](#isbeneficiary)
- [details()](#details)
- [getChainlinkToken()](#getchainlinktoken)
- [deposit(uint256 _value)](#deposit)
- [withdraw(uint256 _value, address _oracle, bytes32 _jobId, string _sym, string _market, uint256 _oraclePayment)](#withdraw)
- [transferFromReserve(address payable _to, uint256 _value)](#transferfromreserve)
- [earn(uint256 _value)](#earn)
- [extendLockingPeriod(uint256 _newPeriod)](#extendlockingperiod)
- [requestAssetPrice(address _oracle, bytes32 _jobId, string _sym, string _market, uint256 _oraclePayment)](#requestassetprice)
- [fulfill(bytes32 _requestId, uint256 _price)](#fulfill)
- [withdrawLink()](#withdrawlink)
- [_deposit(address _token, uint256 _value)](#_deposit)
- [_withdraw(address payable _recepient, address _token, uint256 _value)](#_withdraw)

### 

constructor

```js
function (address _link, address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) public nonpayable LiquidityReserveState 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _link | address |  | 
| _liquidityProvider | address | liquidity provider address | 
| _alkemiNetwork | address | Alkemi Network contract address | 
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _asset | address |  | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

### isActive

check if reserve is active

```js
function isActive() external view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### balance

Get liquidity reserve of a specific token

```js
function balance(address _token) public view
returns(uint256)
```

**Returns**

liquidity reserve token balance

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address | token address | 

### isBeneficiary

Returns true if the beneficiary is the current reserve.

```js
function isBeneficiary() public view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### details

Get reserve details

```js
function details() public view
returns(address, uint256, uint256, uint256, uint256, uint256)
```

**Returns**

asset address, locking period, locking price, total balance, deposited amount, earned amount

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### getChainlinkToken

Returns the address of the LINK token

```js
function getChainlinkToken() public view
returns(address)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### deposit

Deposit `_value` to the reserve

```js
function deposit(uint256 _value) external payable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _value | uint256 | Amount of tokens being transferred | 

### withdraw

Withdraw `_value` from the reserve

```js
function withdraw(uint256 _value, address _oracle, bytes32 _jobId, string _sym, string _market, uint256 _oraclePayment) external nonpayable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _value | uint256 | Amount of tokens being transferred | 
| _oracle | address | oracle address | 
| _jobId | bytes32 | oracle job id | 
| _sym | string | asset symbol | 
| _market | string | market currency needed | 
| _oraclePayment | uint256 | amount of Link tokens for node | 

### transferFromReserve

Transfer asset from reserve to a specific address

```js
function transferFromReserve(address payable _to, uint256 _value) external nonpayable onlyAlkemi 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _to | address payable | recepient address | 
| _value | uint256 | value to send | 

### earn

increment reserve earning

```js
function earn(uint256 _value) external nonpayable onlyAlkemi 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _value | uint256 |  | 

### extendLockingPeriod

extend reserve locking period

```js
function extendLockingPeriod(uint256 _newPeriod) external nonpayable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _newPeriod | uint256 |  | 

### requestAssetPrice

send request to Chainlink nodes to get asset price

```js
function requestAssetPrice(address _oracle, bytes32 _jobId, string _sym, string _market, uint256 _oraclePayment) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _oracle | address | oracle address | 
| _jobId | bytes32 | oracle job id | 
| _sym | string | asset symbol | 
| _market | string | market currency needed | 
| _oraclePayment | uint256 | amount of Link tokens for node | 

### fulfill

update asset price and process withdraw

```js
function fulfill(bytes32 _requestId, uint256 _price) public nonpayable recordChainlinkFulfillment 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _requestId | bytes32 | chainlink request id | 
| _price | uint256 | returned price | 

### withdrawLink

Allows the owner to withdraw any LINK balance on the contract

```js
function withdrawLink() public nonpayable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### _deposit

```js
function _deposit(address _token, uint256 _value) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  | 
| _value | uint256 |  | 

### _withdraw

```js
function _withdraw(address payable _recepient, address _token, uint256 _value) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _recepient | address payable |  | 
| _token | address |  | 
| _value | uint256 |  | 

