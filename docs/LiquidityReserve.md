# LiquidityReserve (LiquidityReserve.sol)

View Source: [contracts/liquidity-reserve/LiquidityReserve.sol](../contracts/liquidity-reserve/LiquidityReserve.sol)

**↗ Extends: [LiquidityReserveState](LiquidityReserveState.md)**

**LiquidityReserve**

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
- [isUnlocked(address _token)](#isunlocked)
- [isActive()](#isactive)
- [balance(address _token)](#balance)
- [isBeneficiary()](#isbeneficiary)
- [details()](#details)
- [deposit(uint256 _value)](#deposit)
- [withdraw(uint256 _value)](#withdraw)
- [transferFromReserve(address payable _to, uint256 _value)](#transferfromreserve)
- [earn(uint256 _value)](#earn)
- [extendLockingPeriod(uint256 _newPeriod)](#extendlockingperiod)
- [_deposit(address _token, uint256 _value)](#_deposit)
- [_withdraw(address _token, uint256 _value)](#_withdraw)
- [getTokenPrice(address _token)](#gettokenprice)

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

### transferFromReserve

can only be called from the Alkemi Network contract when ETH are locked

```js
function transferFromReserve(address payable _to, uint256 _value) external nonpayable onlyAlkemi 
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

### extendLockingPeriod

extend reserve locking period

```js
function extendLockingPeriod(uint256 _newPeriod) external nonpayable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _newPeriod | uint256 |  | 

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

## Contracts

* [Address](Address.md)
* [AlkemiNetwork](AlkemiNetwork.md)
* [AlkemiSettlementMock](AlkemiSettlementMock.md)
* [Context](Context.md)
* [ERC20](ERC20.md)
* [ERC20Mintable](ERC20Mintable.md)
* [EtherTokenConstantMock](EtherTokenConstantMock.md)
* [IAlkemiSettlement](IAlkemiSettlement.md)
* [IAlkemiToken](IAlkemiToken.md)
* [IERC20](IERC20.md)
* [ILiquidityReserve](ILiquidityReserve.md)
* [ILiquidityReserveFactory](ILiquidityReserveFactory.md)
* [IOracle](IOracle.md)
* [IOracleGuard](IOracleGuard.md)
* [LiquidityReserve](LiquidityReserve.md)
* [LiquidityReserveFactory](LiquidityReserveFactory.md)
* [LiquidityReserveState](LiquidityReserveState.md)
* [Migrations](Migrations.md)
* [MinterRole](MinterRole.md)
* [Oracle](Oracle.md)
* [OracleGuard](OracleGuard.md)
* [Roles](Roles.md)
* [SafeERC20](SafeERC20.md)
* [SafeMath](SafeMath.md)
* [TokenMock](TokenMock.md)
