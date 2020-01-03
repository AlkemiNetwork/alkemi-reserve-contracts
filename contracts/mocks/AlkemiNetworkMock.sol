pragma solidity ^0.5.0;

/**
 * @title AlkemiNetworkMock
 * @notice A contract to mock AlkemiNetwork functions
 */
contract AlkemiNetworkMock {
    /// @notice owner address
    address public owner;

    /// @notice alkemi oracle address
    address public alkemiOracle;

    /// @notice settlement id
    uint256 public currentSettlementId;

    constructor() public {
        _setOwner(msg.sender);

        currentSettlementId = 1;
    }

    /**
   * @notice Verifies that the caller is the Owner
   */
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "AlkemiNetwork: Only owner can perform this operation"
        );
        _;
    }

    /**
   * @notice Verifies that the calles is Alkemi Oracle
   */
    modifier onlyAlkemiOracle() {
        require(
            msg.sender == alkemiOracle,
            "AlkemiNetwork: Only Alkemi Oracle can perform this operation"
        );
        _;
    }

    /**
   * @notice settlement function
   * @param exchangesAddresses list of exchanges addresses
   * @param surplusTokensAddresses list of surplus tokens
   * @param deficitTokensAddresses list of dificit tokens
   * @param surplus list of surplus amount
   * @param deficit list of deficit
   */
    function doSettlement(
        address[] calldata exchangesAddresses,
        address[] calldata surplusTokensAddresses,
        address[] calldata deficitTokensAddresses,
        uint128[] calldata surplus,
        uint128[] calldata deficit
    ) external onlyAlkemiOracle returns (bool) {
        return true;
    }

    /**
   * @notice Set new owner address
   * @dev can only be called by the AlkemiNetwork owner
   * @param _owner Address of the new Owner
   */
    function setNewOwner(address _owner) public onlyOwner {
        _setOwner(_owner);
    }

    /**
   * @notice Set Alkemi Oracle address
   * @dev can only be called by the AlkemiNetwork owner
   * @param _oracle oracle address
   */
    function setAlkemiOracle(address _oracle) public onlyOwner {
        _setAlkemiOracle(_oracle);
    }

    function _setOwner(address _owner) internal {
        require(
            (_owner != address(0)) && (_owner != address(this)),
            "AlkemiNetwork: invalid owner address"
        );

        owner = _owner;
    }

    function _setAlkemiOracle(address _oracle) internal {
        require(_oracle != address(0), "AlkemiNetwork: invalid oracle address");

        alkemiOracle = _oracle;
    }
}
