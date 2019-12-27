---
layout: default
title: Alkemi Network
nav_order: 3
---

# ChainlinkRequestInterface.sol

View Source: [chainlinkv0.5/contracts/interfaces/ChainlinkRequestInterface.sol](../chainlinkv0.5/contracts/interfaces/ChainlinkRequestInterface.sol)

**↘ Derived Contracts: [Oracle](Oracle.md)**

**ChainlinkRequestInterface**

## Functions

- [oracleRequest(address sender, uint256 requestPrice, bytes32 serviceAgreementID, address callbackAddress, bytes4 callbackFunctionId, uint256 nonce, uint256 dataVersion, bytes data)](#oraclerequest)
- [cancelOracleRequest(bytes32 requestId, uint256 payment, bytes4 callbackFunctionId, uint256 expiration)](#canceloraclerequest)

### oracleRequest

⤿ Overridden Implementation(s): [Oracle.oracleRequest](Oracle.md#oraclerequest)

```js
function oracleRequest(address sender, uint256 requestPrice, bytes32 serviceAgreementID, address callbackAddress, bytes4 callbackFunctionId, uint256 nonce, uint256 dataVersion, bytes data) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| sender | address |  | 
| requestPrice | uint256 |  | 
| serviceAgreementID | bytes32 |  | 
| callbackAddress | address |  | 
| callbackFunctionId | bytes4 |  | 
| nonce | uint256 |  | 
| dataVersion | uint256 |  | 
| data | bytes |  | 

### cancelOracleRequest

⤿ Overridden Implementation(s): [Oracle.cancelOracleRequest](Oracle.md#canceloraclerequest)

```js
function cancelOracleRequest(bytes32 requestId, uint256 payment, bytes4 callbackFunctionId, uint256 expiration) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| requestId | bytes32 |  | 
| payment | uint256 |  | 
| callbackFunctionId | bytes4 |  | 
| expiration | uint256 |  | 

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
