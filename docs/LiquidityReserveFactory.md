---
layout: default
title: Liquidity Reserve Factory
nav_order: 2
parent: Liquidity Reserve
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
