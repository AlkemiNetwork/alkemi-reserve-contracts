---
layout: default
title: Liquidity Reserve
nav_order: 10
has_children: true
---

# Liquidity Reserve

View Source: [contracts/liquidity-reserve/LiquidityReserve.sol](../contracts/liquidity-reserve/LiquidityReserve.sol)

**↗ Extends: [Liquidity Reserve State](LiquidityReserveState.md)**


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

//public members
address public asset;
address public beneficiary;
uint256 public lockingPeriod;
uint256 public lockingPrice;
uint256 public totalBalance;
uint256 public deposited;
uint256 public earned;
uint8 public lockingPricePosition;
bool public isDepositable;

```

**Events**

```js
event ReserveCreate(address indexed liquidityProvider, address indexed beneficiary, uint256  lockingPeriod, uint256  lockingPrice, uint8  lockingPricePosition);
event ReserveDeposit(address indexed token, address indexed sender, uint256  amount);
event ReserveWithdraw(address indexed token, address indexed withdrawer, uint256  amount);
event ReserveApprove(address indexed token, address indexed to, uint256  amount);
event ReserveTransfer(address indexed token, address indexed to, uint256  amount);
```

## Modifiers

- [onlyUnlocked](#onlyunlocked)

### onlyUnlocked

Throws if locking conditions are still valid

```js
modifier onlyUnlocked(address _token) internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  |

## Functions

- [(address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#)
- [isActive()](#isactive)
- [deposit(uint256 _value)](#deposit)
- [withdraw(uint256 _value)](#withdraw)
- [_deposit(address _token, uint256 _value)](#_deposit)
- [_withdraw(address _token, uint256 _value)](#_withdraw)
- [transferEth(address payable _to, uint256 _value)](#transfereth)
- [earn(uint256 _value)](#earn)
- [isUnlocked(address _token)](#isunlocked)
- [getTokenPrice(address _token)](#gettokenprice)
- [balance(address _token)](#balance)
- [isBeneficiary()](#isbeneficiary)

###

constructor

```js
function (address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) public nonpayable LiquidityReserveState
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
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

### deposit

this function can only be called by the liquidity provider or by the settlement contract

```js
function deposit(uint256 _value) external payable onlyPermissioned
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _value | uint256 | Amount of tokens being transferred |

### withdraw

this function can only be called by the liquidity provider or by the settlement contract

```js
function withdraw(uint256 _value) external nonpayable onlyPermissioned
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _value | uint256 | Amount of tokens being transferred |

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
function _withdraw(address _token, uint256 _value) internal nonpayable onlyUnlocked
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  |
| _value | uint256 |  |

### transferEth

can only be called from the Alkemi Network contract when ETH are locked

```js
function transferEth(address payable _to, uint256 _value) external nonpayable onlyAlkemi
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _to | address payable | recepient address |
| _value | uint256 | value to send |

### earn

can only be called from Alkemi Network contract

```js
function earn(uint256 _value) external nonpayable onlyAlkemi
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _value | uint256 |  |

### isUnlocked

Returns true if one of the liquidity provder's conditions are valid

```js
function isUnlocked(address _token) public view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  |

### getTokenPrice

Return token price from settlement contract

```js
function getTokenPrice(address _token) internal view
returns(uint256)
```

**Returns**

token price

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address | token address |

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
