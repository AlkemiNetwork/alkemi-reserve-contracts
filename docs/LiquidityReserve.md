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
address public beneficiary;
uint256 public lockingPeriod;
uint256 public lockingPrice;
uint8 public lockingPricePosition;

```

**Events**

```js
event ReserveCreate(address indexed liquidityProvider, address  liquidityReserveManager, address  settlementContract, address indexed beneficiary, uint256  lockingPeriod, uint256  lockingPrice, uint8  lockingPricePosition);
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

- [(address _liquidityProvider, address _liquidityReserveManager, address _settlementContract, address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#)
- [()](#)
- [deposit(address _token, uint256 _value)](#deposit)
- [withdraw(address _token, uint256 _value)](#withdraw)
- [_deposit(address _token, uint256 _value)](#_deposit)
- [_withdraw(address _token, uint256 _value)](#_withdraw)
- [isUnlocked(address _token)](#isunlocked)
- [getTokenPrice(address _token)](#gettokenprice)
- [balance(address _token)](#balance)
- [isBeneficiary()](#isbeneficiary)

### 

constructor

```js
function (address _liquidityProvider, address _liquidityReserveManager, address _settlementContract, address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) public nonpayable LiquidityReserveState 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityProvider | address | liquidity provider address | 
| _liquidityReserveManager | address | Lequidity Reserve Manager contract address | 
| _settlementContract | address | Settlement contract address | 
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

### 

```js
function () external payable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### deposit

this function can only be called by the liquidity provider or by the settlement contract

```js
function deposit(address _token, uint256 _value) external payable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address | Address of the token being transferred | 
| _value | uint256 | Amount of tokens being transferred | 

### withdraw

this function can only be called by the liquidity provider or by the settlement contract

```js
function withdraw(address _token, uint256 _value) external nonpayable onlyPermissioned 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address | Address of the token being transferred | 
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

## Contracts

* [Address](Address.md)
* [AlkemiSettlement](AlkemiSettlement.md)
* [AlkemiSettlementMock](AlkemiSettlementMock.md)
* [Context](Context.md)
* [ERC20](ERC20.md)
* [ERC20Mintable](ERC20Mintable.md)
* [IAlkemiSettlement](IAlkemiSettlement.md)
* [IAlkemiToken](IAlkemiToken.md)
* [IERC20](IERC20.md)
* [ILiquidityReserve](ILiquidityReserve.md)
* [ILiquidityReserveManager](ILiquidityReserveManager.md)
* [IOracle](IOracle.md)
* [IOracleGuard](IOracleGuard.md)
* [LiquidityReserve](LiquidityReserve.md)
* [LiquidityReserveFactory](LiquidityReserveFactory.md)
* [LiquidityReserveManager](LiquidityReserveManager.md)
* [LiquidityReserveState](LiquidityReserveState.md)
* [Migrations](Migrations.md)
* [MinterRole](MinterRole.md)
* [Oracle](Oracle.md)
* [OracleGuard](OracleGuard.md)
* [Roles](Roles.md)
* [SafeERC20](SafeERC20.md)
* [SafeMath](SafeMath.md)
* [Token](Token.md)
* [TokenMock](TokenMock.md)
