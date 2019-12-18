---
layout: default
title: Liquidity Reserve Factory
nav_order: 1
---

# Liquidity Reserve Factory 

View Source: [contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol](../contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol)

**↘ Derived Contracts: [AlkemiNetwork](AlkemiNetwork.md), [LiquidityReserveManager](LiquidityReserveManager.md)**


This Factory creates a Liquidity Reserve

## Functions

- [_createLiquidityReserve(address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#_createliquidityreserve)

### _createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function _createLiquidityReserve(address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) internal nonpayable
returns(address)
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _liquidityProvider | address | Lequidity provider address | 
| _alkemiNetwork | address | Alkemi Network contract address | 
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _asset | address |  | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

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
