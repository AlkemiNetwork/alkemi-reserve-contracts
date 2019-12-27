pragma solidity ^0.5.0;

contract EtherTokenConstantMock {

    address constant ETH = address(0);
    
    function getETHConstant() external pure returns (address) { return ETH ; }
}
