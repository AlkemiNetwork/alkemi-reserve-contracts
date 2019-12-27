---
layout: default
title: LiquidityReserveFactory
nav_order: 3
---

# LiquidityReserveFactory (LiquidityReserveFactory.sol)

View Source: [contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol](../contracts/liquidity-reserve/factory/LiquidityReserveFactory.sol)

**↘ Derived Contracts: [AlkemiNetwork](AlkemiNetwork.md)**

**{{ContractName}}**

This Factory creates a Liquidity Reserve

## Functions

- [_createLiquidityReserve(address _linkToken, address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)](#_createliquidityreserve)

### _createLiquidityReserve

Creates and initialises a new LiquidityReserve

```js
function _createLiquidityReserve(address _linkToken, address _liquidityProvider, address _alkemiNetwork, address _beneficiary, address _asset, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition) internal nonpayable
returns(address)
```

**Returns**

Address of new Liquidity Reserve

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _linkToken | address |  | 
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
* [AlkemiOracle](AlkemiOracle.md)
* [AlkemiSettlementMock](AlkemiSettlementMock.md)
* [Buffer](Buffer.md)
* [CBOR](CBOR.md)
* [Chainlink](Chainlink.md)
* [ChainlinkClient](ChainlinkClient.md)
* [ChainlinkOracle](ChainlinkOracle.md)
* [ChainlinkRequestInterface](ChainlinkRequestInterface.md)
* [Context](Context.md)
* [ENSInterface](ENSInterface.md)
* [ENSResolver](ENSResolver.md)
* [ERC20](ERC20.md)
* [ERC20Detailed](ERC20Detailed.md)
* [ERC20Mintable](ERC20Mintable.md)
* [EtherTokenConstantMock](EtherTokenConstantMock.md)
* [IAlkemiSettlement](IAlkemiSettlement.md)
* [IAlkemiToken](IAlkemiToken.md)
* [IERC20](IERC20.md)
* [ILiquidityReserve](ILiquidityReserve.md)
* [ILiquidityReserveFactory](ILiquidityReserveFactory.md)
* [IOracle](IOracle.md)
* [IOracleGuard](IOracleGuard.md)
* [LinkTokenInterface](LinkTokenInterface.md)
* [LinkTokenReceiver](LinkTokenReceiver.md)
* [LiquidityReserve](LiquidityReserve.md)
* [LiquidityReserveFactory](LiquidityReserveFactory.md)
* [LiquidityReserveState](LiquidityReserveState.md)
* [Migrations](Migrations.md)
* [MinterRole](MinterRole.md)
* [Oracle](Oracle.md)
* [OracleGuard](OracleGuard.md)
* [OracleInterface](OracleInterface.md)
* [Ownable](Ownable.md)
* [PointerInterface](PointerInterface.md)
* [Roles](Roles.md)
* [SafeERC20](SafeERC20.md)
* [SafeMath](SafeMath.md)
* [TokenMock](TokenMock.md)
