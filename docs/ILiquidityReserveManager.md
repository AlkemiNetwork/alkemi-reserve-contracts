# ILiquidityReserveManager (ILiquidityReserveManager.sol)

View Source: [contracts/interfaces/ILiquidityReserveManager.sol](../contracts/interfaces/ILiquidityReserveManager.sol)

**ILiquidityReserveManager**

## Functions

- [createLiquidityReserve(address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#createliquidityreserve)
- [liquidityReserveOf(address _liquidityProvider)](#liquidityreserveof)
- [setNewOwner(address _owner)](#setnewowner)

### createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function createLiquidityReserve(address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) external nonpayable
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
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
function setNewOwner(address _owner) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _owner | address | Address of the new Owner | 

## Contracts

* [Address](Address.md)
* [AlkemiNetwork](AlkemiNetwork.md)
* [AlkemiSettlement](AlkemiSettlement.md)
* [AlkemiSettlementMock](AlkemiSettlementMock.md)
* [Context](Context.md)
* [ERC20](ERC20.md)
* [ERC20Mintable](ERC20Mintable.md)
* [EtherTokenConstantMock](EtherTokenConstantMock.md)
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
