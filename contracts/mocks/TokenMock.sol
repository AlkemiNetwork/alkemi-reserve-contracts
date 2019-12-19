pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";

/**
 * @notice ERC20 Mintable token mock
 */
contract TokenMock is ERC20Detailed, ERC20Mintable {

    constructor (string memory name, string memory symbol, uint8 decimals) public ERC20Detailed(name, symbol, decimals) {
    }
}
