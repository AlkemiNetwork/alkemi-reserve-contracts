---
layout: default
title: Minter Role
nav_order: 12
---

# Minter Role

View Source: [@openzeppelin/contracts/access/roles/MinterRole.sol](../@openzeppelin/contracts/access/roles/MinterRole.sol)

**↗ Extends: [Context](Context.md)**
**↘ Derived Contracts: [ERC20Mintable](ERC20Mintable.md)**


## Contract Members
**Constants & Variables**

```js
struct Roles.Role private _minters;

```

**Events**

```js
event MinterAdded(address indexed account);
event MinterRemoved(address indexed account);
```

## Modifiers

- [onlyMinter](#onlyminter)

### onlyMinter

```js
modifier onlyMinter() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [()](#)
- [isMinter(address account)](#isminter)
- [addMinter(address account)](#addminter)
- [renounceMinter()](#renounceminter)
- [_addMinter(address account)](#_addminter)
- [_removeMinter(address account)](#_removeminter)

###

```js
function () internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### isMinter

```js
function isMinter(address account) public view
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| account | address |  |

### addMinter

```js
function addMinter(address account) public nonpayable onlyMinter
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| account | address |  |

### renounceMinter

```js
function renounceMinter() public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### _addMinter

```js
function _addMinter(address account) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| account | address |  |

### _removeMinter

```js
function _removeMinter(address account) internal nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| account | address |  |
