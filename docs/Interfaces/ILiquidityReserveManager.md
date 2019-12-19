---
layout: default
title: Liquidity Reserve Manager (Interface)
nav_order: 6
parent: Interfaces
---

# Liquidity Reserve Manager (Interface)

View Source: [contracts/interfaces/ILiquidityReserveManager.sol](../contracts/interfaces/ILiquidityReserveManager.sol)


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
