pragma solidity ^0.5.0;

contract OracleGuard {

  // Alkemi oracle contract address
  address internal _oracleContract;

  // Alkemi token address
  address internal _alkemiToken;

  // required minimum amount of tokens to run book keeper node
  uint256 internal _requiredTokens;

  uint256 internal _nodesCounter;

  // --- Auth ---
  // 1: OracleGuard Owner permission
  // 2: OracleContract permission
  mapping (address => uint) public auths;

  // Whitelisted contracts, set by an auth
  mapping (address => uint256) public contracts;
  
  // Mapping for nodes, set by an auth
  // 0: node not authenticated
  // 1: node authenticated
  // 2: node banned
  // 3: slashed node (does not have minimum amount of tokens)
  mapping (address => uint256) public nodes;

  // Authorized nodes, set by an auth
  mapping (uint256 => address) public slot;

  constructor(uint256 minimumTokens) public {
    auths[msg.sender] = 1;

    _oracleContract = address(0);
    _requiredTokens = minimumTokens;
    _nodesCounter = 0;
  }

  /**
   * @dev Allow only auth enticated sender
   */
  modifier auth(uint permission) {
    require(
      auths[msg.sender] == permission,
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
   * @dev check if node is banned
   * @param _node node address
   * @return true if banned
   */
  function isNodeBan(address _node) external view returns (bool) {
    return ((nodes[_node] == 2) && (slot[uint8(uint256(_node) >> 152)] == address(0)));
  }

  /**
   * @dev check if node is slashed (node does not have minimum token amount)
   * @param _node node address
   * @return true if banned
   */
  function isNodeSlashed(address _node) external view returns (bool) {
    return ((nodes[_node] == 3) && (slot[uint8(uint256(_node) >> 152)] == address(0)));
  }

  /**
   * @dev Set to an address OracleGuard Owner permission
   * @notice can only be called from an authorized sender
   * @param usr address
   * @param permission Permission type
   */
  function rely(address usr, uint permission) external auth(1) {
    auths[usr] = permission;
  }

  /**
   * @dev Remove from an address OracleGuard Owner permission
   * @notice can only be called from an authorized sender
   * @param usr address
   * @param permission Permission type
   */
  function deny(address usr, uint permission) external auth(1) {
    auths[usr] = permission;
  }

  /**
   * @dev Register node
   * @notice Node can only be registered by Alkemi
   * @param a node address
   */
  function registerNode(address[] calldata a) external auth(1) {
    for (uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid oracle address");
      uint8 s = uint8(uint256(a[i]) >> 152);
      require(slot[s] == address(0), "OracleGuard: oracle already authorized");
      nodes[a[i]] = 1;
      slot[s] = a[i];
      _nodesCounter++;
    }
  }

  /**
   * @dev Auth node to call oracle
   * @notice can only be called from an authorized sender
   * @param a nodes addresses
   */
  function authNode(address[] calldata a) external auth(2) {
    for (uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid oracle address");
      uint8 s = uint8(uint256(a[i]) >> 152);
      require(slot[s] == address(0), "OracleGuard: oracle already authorized");
      nodes[a[i]] = 1;
      slot[s] = a[i];
      _nodesCounter++;
    }
  }

  /**
   * @dev Ban node
   * @notice can only be called from an authorized sender
   * @param a node address
   */
  function dropNode(address a) external auth(2) {
    nodes[a] = 2;
    slot[uint8(uint256(a) >> 152)] = address(0);
    _nodesCounter--;
  }

  /**
   * @dev Auth contracts to call oracle
   * @notice can only be called from an authorized sender
   * @param a contracts addresseses
   */
  function authContract(address[] calldata a) external auth(1) {
    for(uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid contract address");
      contracts[a[i]] = 1;
    }
  }

  /**
   * @dev Ban contract
   * @notice can only be called from an authorized sender
   * @param a contract address
   */
  function dropContract(address a) external auth(1) {
    contracts[a] = 0;
  }

  /**
   * @dev Set on-chain oracle address
   * @notice can only be called from an authorized sender
   * @param oracleContract oracle contract address
   */
  function setOracleContract(address oracleContract) external auth(1) {
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
  function setTokenContract(address alkemiToken) external auth(1) {
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

  /**
   * @dev Get the amount of required tokens to run node
   */
  function requiredToken() public view returns (uint256) {
    return _requiredTokens;
  }

  /**
   * @dev Get number of nodes available to vote
   */
  function nodesAvailable() public view returns (uint256) {
    return _nodesCounter;
  }
}