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
  
  // Mapping for nodes, set by an auth
  mapping (address => uint256) public nodes;

  // Authorized nodes, set by an auth
  mapping (uint256 => address) public slot;

  uint256 nodesCounter;

  constructor() public {
    auths[msg.sender] = 1;

    _oracleContract = address(0);
    nodesCounter = 0;
  }

  /**
   * @dev Allow only authorized sender
   */
  modifier auth {
    require(
      (auths[msg.sender] == 1) || (auths[msg.sender] == 2),
      "OracleGuard: not authorized");
    _;
  }

  /**
   * @dev Check if contract is authorized to call oracle
   * @param _contract contract address
   * @return true if authorized
   */
  function isContractAuth(address _contract) external view returns (bool) {
    return (contracts[_contract] == 1);
  }

  /**
   * @dev Check if node is authorized to submit book to oracle
   * @param _node node address
   * @return true if authorized
   */
  function isNodeAuth(address _node) external view returns (bool) {
    return ((nodes[_node] == 1) && (slot[uint8(uint256(_node) >> 152)] == _node));
  }

  /**
   * @dev Set to an address OracleGuard Owner permission
   * @notice can only be called from an authorized sender
   * @param usr address
   */
  function rely(address usr) external auth {
    auths[usr] = 1;
  }

  /**
   * @dev Remove from an address OracleGuard Owner permission
   * @notice can only be called from an authorized sender
   * @param usr address
   */
  function deny(address usr) external auth {
    auths[usr] = 0;
  }

  /**
   * @dev Auth node to call oracle
   * @notice can only be called from an authorized sender
   * @param a node address
   */
  function authNode(address a) external auth {
    require(a != address(0), "OracleGuard: invalid oracle address");
    uint8 s = uint8(uint256(a) >> 152);
    require(slot[s] == address(0), "OracleGuard: oracle already authorized");
    nodes[a] = 1;
    slot[s] = a;
    nodesCounter++;
  }

  /**
   * @dev Ban node
   * @notice can only be called from an authorized sender
   * @param a node address
   */
  function dropNode(address a) external auth {
    //nodes[a[i]] = 0;
    slot[uint8(uint256(a) >> 152)] = address(0);
    nodesCounter--;
  }

  /**
   * @dev Auth node to call oracle
   * @notice can only be called from an authorized sender
   * @param a nodes addresses
   */
  function authNode(address[] calldata a) external auth {
    for (uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid oracle address");
      uint8 s = uint8(uint256(a[i]) >> 152);
      require(slot[s] == address(0), "OracleGuard: oracle already authorized");
      nodes[a[i]] = 1;
      slot[s] = a[i];
      nodesCounter++;
    }
  }

  /**
   * @dev Ban node
   * @notice can only be called from an authorized sender
   * @param a nodes addresses
   */
  function dropNode(address[] calldata a) external auth {
    for (uint i = 0; i < a.length; i++) {
      //nodes[a[i]] = 0;
      slot[uint8(uint256(a[i]) >> 152)] = address(0);
      nodesCounter--;
    }
  }

  /**
   * @dev Auth contract to call oracle
   * @notice can only be called from an authorized sender
   * @param a contract addresses
   */
  function authContract(address a) external auth {
    require(a != address(0), "OracleGuard: invalid contract address");
    contracts[a] = 1;
  }

  /**
   * @dev Ban contract
   * @notice can only be called from an authorized sender
   * @param a contract address
   */
  function dropContract(address a) external auth {
    contracts[a] = 0;
  }

  /**
   * @dev Auth contracts to call oracle
   * @notice can only be called from an authorized sender
   * @param a contracts addresseses
   */
  function authContract(address[] calldata a) external auth {
    for(uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid contract address");
      contracts[a[i]] = 1;
    }
  }

  /**
   * @dev Ban contracts
   * @notice can only be called from an authorized sender
   * @param a contracts addresses
   */
  function dropContract(address[] calldata a) external auth {
    for(uint i = 0; i < a.length; i++) {
      contracts[a[i]] = 0;
    }
  }

  /**
   * @dev Set on-chain oracle address
   * @notice can only be called from an authorized sender
   * @param oracleContract oracle contract address
   */
  function setOracleContract(address oracleContract) external auth {
    require(oracleContract != address(0), "OracleGuard: invalid address");

    // Remove oracle permissions
    auths[_oracleContract] = 0;

    _oracleContract = oracleContract;
    auths[oracleContract] = 2;
  }

  /**
   * @dev Set Alkemi Token address
   * @notice can only be called from an authorized sender
   * @param alkemiToken Alkemi Token address
   */
  function setTokenContract(address alkemiToken) external auth {
    require(alkemiToken != address(0), "OracleGuard: invalid address");

    _alkemiToken = alkemiToken;
  }

  /**
   * @dev Get on-chain oracle address
   */
  function oracle() public view returns (address) {
    return _oracleContract;
  }

  /**
   * @dev Get Alkemi Token address
   */
  function token() public view returns (address) {
    return _alkemiToken;
  }
}