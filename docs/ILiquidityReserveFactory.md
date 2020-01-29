---
layout: default
title: ILiquidityReserveFactory
---

# ILiquidityReserveFactory (ILiquidityReserveFactory.sol)

View Source: [contracts/interfaces/ILiquidityReserveFactory.sol](../contracts/interfaces/ILiquidityReserveFactory.sol)

**{{ContractName}}**

## Functions

- [createLiquidityReserve(address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#createliquidityreserve)

### createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function createLiquidityReserve(address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) external nonpayable
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

