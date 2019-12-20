---
layout: default
title: ERC20 Mintable
nav_order: 7
---

# ERC20 Mintable

---

**↗ Extends: [ERC20](ERC20.md), [MinterRole](MinterRole.md)**
**↘ Derived Contracts: [Token](Token.md), [TokenMock](TokenMock.md)**


Extension of {ERC20} that adds a set of accounts with the {MinterRole},
which have permission to mint (create) new tokens as they see fit.
 * At construction, the deployer of the contract is the only minter.

---

## Functions

- [mint(address account, uint256 amount)](#mint)

### mint

See {ERC20-_mint}.
     * Requirements:
     * - the caller must have the {MinterRole}.

```js
function mint(address account, uint256 amount) public nonpayable onlyMinter
returns(bool)
```

**Arguments**

| Name        | Type           | Description  |
| ------------- |------------- | -----|
| account | address |  |
| amount | uint256 |  |
