# Oracle.sol

View Source: [contracts/oracles/Oracle.sol](../contracts/oracles/Oracle.sol)

**Oracle**

**Enums**
### Vote

```js
enum Vote {
 YES,
 NO
}
```

## Structs
### SettlementVoting

```js
struct SettlementVoting {
 address node,
 bytes32 bookHash,
 uint256 minimumVotes,
 uint256 yesVotes,
 uint256 noVotes,
 address[] exchangesAddresses,
 address[] surplusTokensAddresses,
 address[] deficitTokensAddresses,
 uint128[] surplus,
 uint128[] deficit
}
```

## Contract Members
**Constants & Variables**

```js
//internal members
uint256 internal _currentSettlementId;
contract IAlkemiSettlement internal _settlementContract;
contract IOracleGuard internal _oracleGuard;

//public members
mapping(uint256 => address[]) public settlementBannedNode;
mapping(uint256 => bytes32) public settlementBookHash;
mapping(bytes32 => struct Oracle.SettlementVoting) public settlementVoting;
mapping(bytes32 => mapping(address => bool)) public accountingVotedNode;

```

**Events**

```js
event RequestAccountingBook(uint256 indexed settlementId);
event RequestVote(uint256 indexed settlementId, bytes32  bookHash);
event RequestStopTrade(uint256  settlementId);
event RequestContinueTrade(uint256  settlementId, uint256  settlementTimeStamp);
```

## Functions

- [(address settlementContract, address oracleGuard)](#)
- [getSettlementId()](#getsettlementid)
- [submitBook(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit, uint256 _settlementId, bytes32 _bookHash)](#submitbook)
- [settlementVote(uint256 _settlementId, bytes32 _bookHash, uint8 _vote)](#settlementvote)
- [restartContainersTrading(uint256 settlementId, uint256 settlementTime)](#restartcontainerstrading)
- [requestAccountingBook(uint256 _settlementId)](#requestaccountingbook)
- [stopContainersTrading(uint256 settlementId)](#stopcontainerstrading)

### 

```js
function (address settlementContract, address oracleGuard) public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| settlementContract | address |  | 
| oracleGuard | address |  | 

### getSettlementId

```js
function getSettlementId() external nonpayable
returns(uint256)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### submitBook

submit book hash and settlement details to vote for

```js
function submitBook(address[] exchangesAddresses, address[] surplusTokensAddresses, address[] deficitTokensAddresses, uint128[] surplus, uint128[] deficit, uint256 _settlementId, bytes32 _bookHash) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| exchangesAddresses | address[] | list of exchanges addresses | 
| surplusTokensAddresses | address[] | list of tokens for surplus | 
| deficitTokensAddresses | address[] | list of tokens for deficit | 
| surplus | uint128[] | TokensAddresses list of tokens for surplus | 
| deficit | uint128[] | TokensAddresses list of tokens for deficit | 
| _settlementId | uint256 | book settlement id | 
| _bookHash | bytes32 | book hash | 

### settlementVote

```js
function settlementVote(uint256 _settlementId, bytes32 _bookHash, uint8 _vote) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _settlementId | uint256 |  | 
| _bookHash | bytes32 |  | 
| _vote | uint8 |  | 

### restartContainersTrading

```js
function restartContainersTrading(uint256 settlementId, uint256 settlementTime) external nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| settlementId | uint256 |  | 
| settlementTime | uint256 |  | 

### requestAccountingBook

```js
function requestAccountingBook(uint256 _settlementId) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| _settlementId | uint256 |  | 

### stopContainersTrading

```js
function stopContainersTrading(uint256 settlementId) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| settlementId | uint256 |  | 

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
