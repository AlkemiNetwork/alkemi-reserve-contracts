pragma solidity ^0.5.0;

contract OracleGuard {

  // Alkemi oracle contract address
  address internal _oracleContract;

  // Alkemi token address
  address internal _alkemiToken;

  // --- Auth ---
  // 1: OracleGuard Owner permission
  // 2: OracleContract permission
  mapping (address => uint) public auths;

  // Whitelisted contracts, set by an auth
  mapping (address => uint256) public contracts;
  
  // Mapping for off-chain nodes, set by an auth
  mapping (address => uint256) public nodes;

  // Authorized off-chain nodes, set by an auth
  mapping (uint256 => address) public slot;

  constructor() public {
    auths[msg.sender] = 1;
  }

  modifier auth {
    require(
      (auths[msg.sender] == 1) || (auths[msg.sender] == 2),
      "OracleGuard: not authorized");
    _;
  }

  function isContractAuth(address _contract) external view returns (bool) {
    return (contracts[_contract] == 1);
  }

  function isNodeAuth(address _node) external view returns (bool) {
    return ((nodes[_node] == 1) && (slot[uint8(uint256(_node) >> 152)] == _node));
  }

  function rely(address usr) external auth {
    auths[usr] = 1;
  }

  function deny(address usr) external auth {
    auths[usr] = 0;
  }

  function authNode(address a) external auth {
    require(a != address(0), "OracleGuard: invalid oracle address");
    uint8 s = uint8(uint256(a) >> 152);
    require(slot[s] == address(0), "OracleGuard: oracle already authorized");
    nodes[a] = 1;
    slot[s] = a;
  }

  function dropNode(address a) external auth {
    //nodes[a[i]] = 0;
    slot[uint8(uint256(a) >> 152)] = address(0);
  }

  function authNode(address[] calldata a) external auth {
    for (uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid oracle address");
      uint8 s = uint8(uint256(a[i]) >> 152);
      require(slot[s] == address(0), "OracleGuard: oracle already authorized");
      nodes[a[i]] = 1;
      slot[s] = a[i];
    }
  }

  function dropNode(address[] calldata a) external auth {
    for (uint i = 0; i < a.length; i++) {
      //nodes[a[i]] = 0;
      slot[uint8(uint256(a[i]) >> 152)] = address(0);
    }
  }

  function authContract(address a) external auth {
    require(a != address(0), "OracleGuard: invalid contract address");
    contracts[a] = 1;
  }

  function dropContract(address a) external auth {
    contracts[a] = 0;
  }

  function authContract(address[] calldata a) external auth {
    for(uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid contract address");
      contracts[a[i]] = 1;
    }
  }

  function dropContract(address[] calldata a) external auth {
    for(uint i = 0; i < a.length; i++) {
      contracts[a[i]] = 0;
    }
  }

  function setOracleContract(address oracleContract) external auth {
    require(oracleContract != address(0), "OracleGuard: invalid address");

    // Remove oracle permissions
    auths[_oracleContract] = 0;

    _oracleContract = oracleContract;
    auths[oracleContract] = 2;
  }

  function setTokenContract(address alkemiToken) external auth {
    require(alkemiToken != address(0), "OracleGuard: invalid address");

    _alkemiToken = alkemiToken;
  }

  function oracle() public view returns (address) {
    return _oracleContract;
  }

  function token() public view returns (address) {
    return _alkemiToken;
  }
}