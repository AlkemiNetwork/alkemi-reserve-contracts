---
layout: default
title: LiquidityReserveFactory
---

# LiquidityReserveFactory (LiquidityReserveFactory.sol)

View Source: [contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol](../contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol)

**↘ Derived Contracts: [AlkemiNetwork](AlkemiNetwork.md)**

**{{ContractName}}**

This Factory creates a Liquidity Reserve

## Functions

- [_createLiquidityReserve(address _linkToken, address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _createdAt, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#_createliquidityreserve)

### _createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function _createLiquidityReserve(address _linkToken, address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _createdAt, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) internal nonpayable
returns(address)
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _linkToken | address | LINK token address | 
| _liquidityProvider | address | Lequidity provider address | 
| _alkemiNetwork | address | Alkemi Network contract address | 
| _beneficiary | address | earnings beneficiary (address(0) if the earnings goes to the current reserve address) | 
| _asset | address | reserve asset | 
| _createdAt | uint256 | reserve created time | 
| _lockingPeriod | uint256 | funds locking period | 
| _lockingPrice | uint256 | release funds when hitting this price | 
| _lockingPricePosition | uint8 | locking price position | 

