pragma solidity ^0.5.0;

contract OracleGuard {

  /// @notice Alkemi oracle contract address
  address public alkemiOracle;

  /// @notice Alkemi token address
  address public alkemiToken;

  /// @notice required minimum amount of tokens to run book keeper node
  uint256 public requiredTokens;

  /// @notice number of available nodes
  uint256 public nodesCounter;

  // --- Auth ---
  // 1: OracleGuard Owner permission
  // 2: OracleContract permission
  mapping (address => uint) public auths;

  /// @notice Whitelisted contracts, set by an auth
  mapping (address => uint256) public contracts;
  
  /// @notice Mapping for nodes, set by an auth
  // 0: node not authenticated
  // 1: node authenticated
  // 2: node banned
  // 3: slashed node (does not have minimum amount of tokens)
  mapping (address => uint256) public nodes;

  /// @notice Authorized nodes, set by an auth
  mapping (uint256 => address) public slot;

  /**
   * @notice constructor
   * @param minimumTokens required Alkemi Token for nodes to submit book
   */
  constructor(uint256 minimumTokens) public {
    auths[msg.sender] = 1;

    alkemiOracle = address(0);
    requiredTokens = minimumTokens;
    nodesCounter = 0;
  }

  /**
   * @notice Allow only authenticated sender
   */
  modifier auth(uint permission) {
    require(
      auths[msg.sender] == permission,
      "OracleGuard: not authorized");
    _;
  }

  /**
   * @notice Check if contract is authorized to call Alkemi Oracle
   * @param _contract contract address
   * @return true if authorized
   */
  function isContractAuth(address _contract) external view returns (bool) {
    return (contracts[_contract] == 1);
  }

  /**
   * @notice Check if node is authorized to submit book to Alkemi Oracle
   * @param _node node address
   * @return true if authorized
   */
  function isNodeAuth(address _node) external view returns (bool) {
    return ((nodes[_node] == 1) && (slot[uint8(uint256(_node) >> 152)] == _node));
  }

  /**
   * @notice check if node is banned
   * @param _node node address
   * @return true if banned
   */
  function isNodeBan(address _node) external view returns (bool) {
    return ((nodes[_node] == 2) && (slot[uint8(uint256(_node) >> 152)] == address(0)));
  }

  /**
   * @notice check if node is slashed (node does not have minimum token amount)
   * @param _node node address
   * @return true if banned
   */
  function isNodeSlashed(address _node) external view returns (bool) {
    return ((nodes[_node] == 3) && (slot[uint8(uint256(_node) >> 152)] == address(0)));
  }

  /**
   * @notice Grant to an address permission
   * @dev can only be called from an authorized sender
   * @param usr address
   * @param permission Permission type
   */
  function rely(address usr, uint permission) external auth(1) {
    auths[usr] = permission;
  }

  /**
   * @notice Remove from an address OracleGuard Owner permission
   * @dev can only be called from an authorized sender
   * @param usr address
   * @param permission Permission type
   */
  function deny(address usr, uint permission) external auth(1) {
    auths[usr] = permission;
  }

  /**
   * @notice Register node
   * @dev Node can only be registered by Alkemi
   * @param a node address
   */
  function registerNode(address[] calldata a) external auth(1) {
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
   * @notice Auth node to call oracle
   * @dev can only be called from an authorized sender
   * @param a nodes addresses
   */
  function authNode(address[] calldata a) external auth(2) {
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
   * @notice Ban node
   * @dev can only be called from an authorized sender
   * @param a node address
   */
  function dropNode(address a) external auth(2) {
    nodes[a] = 2;
    slot[uint8(uint256(a) >> 152)] = address(0);
    nodesCounter--;
  }

  /**
   * @notice Auth contracts to call oracle
   * @dev can only be called from an authorized sender
   * @param a contracts addresseses
   */
  function authContract(address[] calldata a) external auth(1) {
    for(uint i = 0; i < a.length; i++) {
      require(a[i] != address(0), "OracleGuard: invalid contract address");
      contracts[a[i]] = 1;
    }
  }

  /**
   * @notice Ban contract
   * @dev can only be called from an authorized sender
   * @param a contract address
   */
  function dropContract(address a) external auth(1) {
    contracts[a] = 0;
  }

  /**
   * @notice Set on-chain oracle address
   * @dev can only be called from an authorized sender
   * @param oracleContract oracle contract address
   */
  function setOracleContract(address oracleContract) external auth(1) {
    require(oracleContract != address(0), "OracleGuard: invalid address");

    // Remove oracle permissions
    auths[alkemiOracle] = 0;

    alkemiOracle = oracleContract;
    auths[oracleContract] = 2;
  }

  /**
   * @notice Set Alkemi Token address
   * @dev can only be called from an authorized sender
   * @param _alkemiToken Alkemi Token address
   */
  function setTokenContract(address _alkemiToken) external auth(1) {
    require(_alkemiToken != address(0), "OracleGuard: invalid address");

    alkemiToken = _alkemiToken;
  }
}