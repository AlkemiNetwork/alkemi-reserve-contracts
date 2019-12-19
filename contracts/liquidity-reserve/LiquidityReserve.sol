pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "chainlinkv0.5/contracts/ChainlinkClient.sol";
import "./LiquidityReserveState.sol";

import "../interfaces/IAlkemiSettlement.sol";

/**
  * @title LiquidityReserve
  * @dev Base layer functionality for the Liquidity Reserve
  */
contract LiquidityReserve is ChainlinkClient, LiquidityReserveState {
  using SafeERC20 for ERC20;
  using SafeMath for uint256;

  address internal constant ETH = address(0);

  address public asset;
  address public beneficiary;
  uint256 public lockingPeriod;
  uint256 public lockingPrice;
  uint256 public totalBalance;
  uint256 public deposited;
  uint256 public earned;
  uint8 public lockingPricePosition;      // 0=below the lockingPrice; 1=above the lockingPrice
  bool public isDepositable = true;

  uint256 oraclePrice;

  /**
   * @dev Price lockout actions
   */
  enum PriceLockout {
    BELOW,
    ABOVE
  }

  event ReserveDeposit(
    address indexed token,
    address indexed sender,
    uint256 amount
  );
  event ReserveWithdraw(
    address indexed token,
    address indexed withdrawer,
    uint256 amount
  );
  event ReserveApprove(
    address indexed token,
    address indexed to,
    uint256 amount
  );
  event ReserveTransfer(
    address indexed token,
    address indexed to,
    uint256 amount
  );

  /**
   * @dev constructor
   * @param _liquidityProvider liquidity provider address
   * @param _alkemiNetwork Alkemi Network contract address
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   */
  constructor(
    address _link,
    address _liquidityProvider,
    address _alkemiNetwork,
    address _beneficiary,
    address _asset,
    uint256 _lockingPeriod,
    uint256 _lockingPrice,
    uint8 _lockingPricePosition
  )
    public
    LiquidityReserveState(_alkemiNetwork, _liquidityProvider)
  {
    require(
      _lockingPeriod > now,
      "LiquidityReserve: invalid locking period timestamp"
    );
    require(
      _lockingPrice > 0,
      "LiquidityReserve: invalid price lockout"
    );

    // Set the address for the LINK token for the network.
    if(_link == address(0)) {
      // Useful for deploying to public networks.
      setPublicChainlinkToken();
    } else {
      // Useful if you're deploying to a local network.
      setChainlinkToken(_link);
    }

    asset = _asset;
    beneficiary = _beneficiary;
    lockingPeriod = _lockingPeriod;
    lockingPrice = _lockingPrice;

    // if _lockingPricePosition=0 (PriceLockout.BELOW) then unlock funds when oracle price is below lockingPrice (lockingPricePosition = 0)
    // if _lockingPricePosition=1 (PriceLockout.ABOVE) then unlock funds when oracle price is above lockingPrice (lockingPricePosition = 1)
    PriceLockout priceLockout = PriceLockout(_lockingPricePosition);
    if(priceLockout == PriceLockout.BELOW) {
      lockingPricePosition = 0;
    }
    if(priceLockout == PriceLockout.ABOVE) {
      lockingPricePosition = 1;
    }
  }

  /**
   * @dev Throws if locking conditions are still valid
   */
  modifier onlyUnlocked(address _token) {
    require(isUnlocked(_token), "LiquidityReserve: provider locking conditions still valid");
    _;
  }

  /**
   * @dev Returns true if one of the liquidity provder's conditions are valid
   */
  function isUnlocked(address _token) public view returns (bool) {
    if(now > lockingPeriod) return true;

    // get token price from settlement contract
    uint256 tokenOraclePrice = getTokenPrice(_token);
    if(lockingPricePosition == 0) {
      if(tokenOraclePrice < lockingPrice) return true;
    }
    else {
      if(tokenOraclePrice > lockingPrice) return true;
    }
    return false;
  }

  /**
   * @dev check if reserve is active
   */
  function isActive() external view returns(bool) {
    return isDepositable || totalBalance > 0;
  }

  /**
   * @dev Get liquidity reserve of a specific token
   * @param _token token address
   * @return liquidity reserve token balance
   */
  function balance(address _token) public view returns (uint256) {
    if (_token == ETH) {
        return address(this).balance;
    } else {
        return ERC20(_token).balanceOf(address(this));
    }
  }

  /**
   * @dev Returns true if the beneficiary is the current reserve.
   */
  function isBeneficiary() public view returns (bool) {
    return beneficiary == address(0);
  }

  /**
   * @dev Get reserve details
   * @return asset address, locking period, locking price, total balance, deposited amount, earned amount
   */
  function details() public view returns (address, uint256, uint256, uint256, uint256, uint256) {
    return (asset, lockingPeriod, lockingPrice, totalBalance, deposited, earned);
  }

  /**
   * @dev Deposit `_value` to the reserve
   * @notice this function can only be called by the liquidity provider or by the settlement contract
   * @param _value Amount of tokens being transferred
   */
  function deposit(uint256 _value) external payable onlyPermissioned {
    require(_value > 0, "LiquidityReserve: can not deposit amount equal to zero");
    require(isDepositable, "LiquidityReserve: can not deposit into this reserve");
    _deposit(asset, _value);
  }

  /**
   * @dev Withdraw `_value` from the reserve
   * @notice this function can only be called by the liquidity provider or by the settlement contract
   * @param _value Amount of tokens being transferred
   */
  function withdraw(uint256 _value) external onlyPermissioned {
    _withdraw(asset, _value);
  }

  /**
   * @dev Transfer asset from reserve to a specific address
   * @notice can only be called from the Alkemi Network contract when ETH are locked
   * @param _to recepient address
   * @param _value value to send
   */
  function transferFromReserve(address payable _to, uint256 _value) external onlyAlkemi() {
    require(now < lockingPeriod, "LiquidityReserve: funds are unlocked");

    if (asset == ETH) {
      require(address(this).balance >= _value, "LiquidityReserve: insufficient balance");
      _to.transfer(_value);
    } else {
      ERC20(asset).transfer(_to, _value);
    }
  }

  /**
   * @dev increment reserve earning
   * @notice can only be called from Alkemi Network contract
   */
  function earn(uint256 _value) external onlyAlkemi() {
    //earned = earned.add(_value);
    earned = SafeMath.add(earned, _value);
    totalBalance = SafeMath.add(totalBalance, _value);
  }

  /**
   * @dev extend reserve locking period
   */
  function extendLockingPeriod(uint256 _newPeriod) external onlyPermissioned {
    require(_newPeriod > lockingPeriod, "LiquidityReserve: invalid new locking period");
    
    lockingPeriod = _newPeriod;
  }

  function _deposit(address _token, uint256 _value) internal {
    require(_value > 0, "LiquidityReserve: can not deposit 0 amount");

    if (_token == ETH) {
      // Deposit is implicit in this case
      require(msg.value == _value, "LiquidityReserve: ETH value mismatch");
    } else {
      ERC20(_token).safeTransferFrom(msg.sender, address(this), _value);
    }

    isDepositable = false;
    deposited = SafeMath.add(deposited,_value);
    totalBalance = deposited;

    emit ReserveDeposit(_token, msg.sender, _value);
  }

  function _withdraw(address _token, uint256 _value) internal onlyUnlocked(_token) {
    if (_token == ETH) {
      require(address(this).balance >= _value, "LiquidityReserve: insufficient balance");
      msg.sender.transfer(_value);
    } else {
      ERC20(_token).transfer(msg.sender, _value);
    }

    totalBalance = SafeMath.sub(totalBalance, _value);

    emit ReserveWithdraw(_token, msg.sender, _value);
  }

  /**
   * @dev send request to Chainlink nodes to get asset price
   * @param _oracle oracle address
   * @param _jobId oracle job id
   * @param _market market currency needed
   */
  function requestAssetPrice(
    address _oracle,
    bytes32 _jobId,
    string memory _sym,
    string memory _market,
    uint256 _oraclePayment
  ) public {
    require((msg.sender == address(this)) || havePermission(), "LiquidityReserve: not authorized to call price feed oracle");
    
    Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfill.selector);
    req.add("sym", _sym);
    req.add("convert", _market);
    string[] memory path = new string[](5);
    path[0] = "data";
    path[1] = _sym;
    path[2] = "quote";
    path[3] = _market;
    path[4] = "price";
    req.addStringArray("copyPath", path);
    req.addInt("times", 100);
    sendChainlinkRequestTo(_oracle, req, _oraclePayment);
  }

  /**
   * @dev update asset price
   * @notice can only be called by Chainlink oracles when request get fulfilled
   * @param _requestId chainlink request id
   * @param _price returned price
   */
  function fulfill(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId) returns (uint256) {
    oraclePrice = _price;
  }

  /**
   * @notice Allows the owner to withdraw any LINK balance on the contract
   */
  function withdrawLink() public onlyPermissioned {
    LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
    require(link.transfer(msg.sender, link.balanceOf(address(this))), "Unable to transfer");
  }

  /**
   * @notice Returns the address of the LINK token
   * @dev This is the public implementation for chainlinkTokenAddress, which is
   * an internal method of the ChainlinkClient contract
   */
  function getChainlinkToken() public view returns (address) {
    return chainlinkTokenAddress();
  }

  /**
   * @dev Return token price from settlement contract
   * @param _token token address
   * @return token price
   */
  function getTokenPrice(address _token) internal view returns (uint256) {
    // return IAlkemiSettlement(settlementContract()).priceOf(_token);
    return 200;
  }
  
}
