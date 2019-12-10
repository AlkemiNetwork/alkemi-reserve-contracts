# LiquidityReserveFactory (LiquidityReserveFactory.sol)

View Source: [contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol](../contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol)

**↘ Derived Contracts: [LiquidityReserveManager](LiquidityReserveManager.md)**

**LiquidityReserveFactory**

This Factory creates a Liquidity Reserve

## Functions

- [_createLiquidityReserve(address _liquidityProvider, address _liquidityReserveManager, address _settlementContract, address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#_createliquidityreserve)

### _createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function _createLiquidityReserve(address _liquidityProvider, address _liquidityReserveManager, address _settlementContract, address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) internal nonpayable
returns(address)
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityProvider | address | Lequidity provider address | 
| _liquidityReserveManager | address | Lequidity Reserve Manager contract address | 
| _settlementContract | address | Settlement contract address | 
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

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
