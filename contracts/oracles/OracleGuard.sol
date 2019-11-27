pragma solidity ^0.5.0;

contract OracleGuard {

  address internal _oracleContract;

  // --- Auth ---
  mapping (address => uint) public auths;
  
  // Authorized oracles, set by an auth
  mapping (address => uint256) public orcl;

  // Whitelisted contracts, set by an auth
  mapping (address => uint256) public contracts;

  // Mapping for oracles
  mapping (uint256 => address) public slot;

  constructor() public {
    auths[msg.sender] = 1;
  }

  modifier auth {
    require(auths[msg.sender] == 1, "OracleGuard: not authorized");
    _;
  }

  modifier isAuthContract {
    require(contracts[msg.sender] == 1, "OracleGuard: contract not whitelisted");
    _;
  }

  function rely(address usr) external auth {
    auths[usr] = 1;
  }

  function deny(address usr) external auth {
    auths[usr] = 0;
  }

  function authOracles(address[] calldata a) external auth {
    for (uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid oracle address");
      uint8 s = uint8(uint256(a[i]) >> 152);
      require(slot[s] == address(0), "OracleGuard: oracle already exists");
      orcl[a[i]] = 1;
      slot[s] = a[i];
    }
  }

  function dropOracles(address[] calldata a) external auth {
    for (uint i = 0; i < a.length; i++) {
      orcl[a[i]] = 0;
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

  function setOracleContract(address oracleContract) public auth {
    require(oracleContract != address(0), "OracleGuard: invalid address");

    _oracleContract = oracleContract;
  }

  function oracle() public view returns (address) {
    return _oracleContract;
  }
}