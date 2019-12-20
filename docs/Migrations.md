---
layout: default
title: Migrations
nav_order: 11
---

# Migrations

---

View Source: [contracts/Migrations.sol](https://github.com/project-alkemi/alkemi-protocol/blob/master/contracts/Migrations.sol)

---

## Contract Members
**Constants & Variables**

```js
address public owner;
uint256 public last_completed_migration;

```

## Modifiers

- [restricted](#restricted)

### restricted

```js
modifier restricted() internal
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

## Functions

- [()](#)
- [setCompleted(uint256 completed)](#setcompleted)
- [upgrade(address new_address)](#upgrade)

###

```js
function () public nonpayable
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|

### setCompleted

```js
function setCompleted(uint256 completed) public nonpayable restricted
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| completed | uint256 |  |

### upgrade

```js
function upgrade(address new_address) public nonpayable restricted
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| new_address | address |  |
