pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "./Ownable.sol";

/**
  * @title LiquidityReserve
  * @dev Base layer functionality for the Liquidity Reserve
  */
contract LiquidityReserve is Ownable {
  using SafeERC20 for ERC20;

  address internal constant ETH = address(0);

  address public beneficiary;
  uint256 public lockingPeriod;
  uint256 public lockingPrice;
  uint8 public lockingPricePosition;  // 0=below the lockingPrice; 1=above the lockingPrice

  /**
   * @dev Price lockout actions
   */
  enum PriceLockout {
    BELOW,
    ABOVE
  }

  event ReserveCreate(
    address indexed owner,
    address indexed beneficiary,
    uint256 lockingPeriod
  );
  event ReserveDeposit(
    address indexed token,
    address indexed sender,
    uint256 amount
  );
  event ReserveWithdraw(
    address indexed token,
    address indexed sender,
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
   * @param _owner liquidity reserve owner
   * @param _beneficiary earnings beneficiary (address(0) if the earnings goes to the current reserve address)
   * @param _lockingPeriod funds locking period
   * @param _lockingPrice release funds when hitting this price
   * @param _lockingPricePosition locking price position
   */
  constructor(address _owner, address _beneficiary, uint256 _lockingPeriod, uint256 _lockingPrice, uint8 _lockingPricePosition)
    public
    Ownable(_owner)
  {
    require(
      _lockingPeriod > now,
      "LiquidityReserve: invalid locking period timestamp"
    );
    require(
      _lockingPrice > 0,
      "LiquidityReserve: invalid price lockout"
    );

    lockingPeriod = _lockingPeriod;
    beneficiary = _beneficiary;
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

    emit ReserveCreate(owner(), beneficiary, lockingPeriod);
  }

  function() external payable onlyOwner {
    require(msg.data.length == 0, "LiquidityReserve: data non zero");
    _deposit(ETH, msg.value);
  }

  /**
   * @dev Returns true if the beneficiary is the current reserve.
   */
  function isBeneficiary() public view returns (bool) {
    return beneficiary == address(0);
  }

  /**
   * @notice Deposit `_value` `_token` to the reserve
   * @param _token Address of the token being transferred
   * @param _value Amount of tokens being transferred
   */
  function deposit(address _token, uint256 _value) external payable onlyOwner {
    _deposit(_token, _value);
  }

  function _deposit(address _token, uint256 _value) internal {
    require(_value > 0, "LiquidityReserve: can not deposit 0 amount");

    if (_token == ETH) {
      // Deposit is implicit in this case
      require(msg.value == _value, "LiquidityReserve: ETH value mismatch");
    } else {
      ERC20(_token).safeTransferFrom(msg.sender, address(this), _value);
    }

    emit ReserveDeposit(_token, msg.sender, _value);
  }

  function balance(address _token) public view returns (uint256) {
    if (_token == ETH) {
        return address(this).balance;
    } else {
        return ERC20(_token).balanceOf(address(this));
    }
  }

}
