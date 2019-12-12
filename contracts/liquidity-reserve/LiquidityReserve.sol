pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./LiquidityReserveState.sol";

import "../interfaces/IAlkemiSettlement.sol";

/**
  * @title LiquidityReserve
  * @dev Base layer functionality for the Liquidity Reserve
  */
contract LiquidityReserve is LiquidityReserveState {
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
   * @dev check if reserve is active
   */
  function isActive() external view returns(bool) {
    return isDepositable || totalBalance > 0;
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

  function _deposit(address _token, uint256 _value) internal {
    require(_value > 0, "LiquidityReserve: can not deposit 0 amount");

    if (_token == ETH) {
      // Deposit is implicit in this case
      require(msg.value == _value, "LiquidityReserve: ETH value mismatch");
    } else {
      ERC20(_token).safeTransferFrom(msg.sender, address(this), _value);
    }

    isDepositable = false;
    deposited = deposited.add(_value);
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

    totalBalance = totalBalance.sub(_value);

    emit ReserveWithdraw(_token, msg.sender, _value);
  }

  /**
   * @dev Transfer asset to a specific address
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
    earned = earned.add(_value);
    totalBalance = totalBalance.add(_value);
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
   * @dev Return token price from settlement contract
   * @param _token token address
   * @return token price
   */
  function getTokenPrice(address _token) internal view returns (uint256) {
    // return IAlkemiSettlement(settlementContract()).priceOf(_token);
    return 200;
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
  
}
