---
layout: default
title: ChainlinkRequestInterface
---

# ChainlinkRequestInterface.sol

View Source: [chainlinkv0.5/contracts/interfaces/ChainlinkRequestInterface.sol](../chainlinkv0.5/contracts/interfaces/ChainlinkRequestInterface.sol)

**↘ Derived Contracts: [Oracle](Oracle.md)**

**{{ContractName}}**

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

