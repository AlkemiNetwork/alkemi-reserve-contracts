pragma solidity ^0.5.0;

import "chainlinkv0.5/contracts/Oracle.sol";

contract ChainlinkOracle is Oracle {
    
	constructor(address _link) public Oracle(_link) {
	}
}