# LiquidityReserveManager (LiquidityReserveManager.sol)

View Source: [contracts/liquidity-reserve/LiquidityReserveManager.sol](../contracts/liquidity-reserve/LiquidityReserveManager.sol)

**↗ Extends: [LiquidityReserveFactory](LiquidityReserveFactory.md)**

**LiquidityReserveManager**

This contract manages a specific Liquidity Reserve

## Contract Members
**Constants & Variables**

```js
//public members
address public owner;

//private members
mapping(address => address) private _liquidityReserves;

```

## Modifiers

- [onlyOwner](#onlyowner)

### onlyOwner

Verifies that the caller is the Owner

```js
modifier onlyOwner() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [()](#)
- [createLiquidityReserve(address _settlementContract, address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#createliquidityreserve)
- [liquidityReserveOf(address _liquidityProvider)](#liquidityreserveof)
- [setNewOwner(address _owner)](#setnewowner)
- [_setOwner(address _owner)](#_setowner)

### 

```js
function () public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function createLiquidityReserve(address _settlementContract, address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) public nonpayable
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _settlementContract | address | Settlement contract address | 
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

### liquidityReserveOf

Get liquidity reserve address of a liquidity provider

```js
function liquidityReserveOf(address _liquidityProvider) public view
returns(address)
```

**Returns**

liquidity reserve contract address

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityProvider | address | liquidity provider address | 

### setNewOwner

Manager can set the address of the new Owner here

```js
function setNewOwner(address _owner) public nonpayable onlyOwner 
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _owner | address | Address of the new Owner | 

### _setOwner

```js
function _setOwner(address _owner) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _owner | address |  | 

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
