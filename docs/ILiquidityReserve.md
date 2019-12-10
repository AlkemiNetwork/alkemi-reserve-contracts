# ILiquidityReserve (ILiquidityReserve.sol)

View Source: [contracts/interfaces/ILiquidityReserve.sol](../contracts/interfaces/ILiquidityReserve.sol)

**ILiquidityReserve**

## Functions

- [deposit(address _token, uint256 _value)](#deposit)
- [withdraw(address _token, uint256 _value)](#withdraw)
- [isUnlocked(address _token)](#isunlocked)
- [isBeneficiary()](#isbeneficiary)
- [balance(address _token)](#balance)

### deposit

Deposit `_value` `_token` to the reserve

```js
function deposit(address _token, uint256 _value) external payable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address | Address of the token being transferred | 
| _value | uint256 | Amount of tokens being transferred | 

### withdraw

this function can only be called by the liquidity provider or by the settlement contract

```js
function withdraw(address _token, uint256 _value) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address | Address of the token being transferred | 
| _value | uint256 | Amount of tokens being transferred | 

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

### isBeneficiary

Returns true if the beneficiary is the current reserve.

```js
function isBeneficiary() external view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### balance

```js
function balance(address _token) public view
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _token | address |  | 

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
