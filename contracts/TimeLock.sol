// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract TokenTimelock {
    using SafeERC20 for IERC20;

    // ERC20 basic token contract being held
    IERC20 private immutable _token;

    // beneficiary of tokens after they are released
    address[] public _beneficiaries;

    // timestamp when token release is enabled
    uint256 private _releaseTime;
    uint256 public _releasePeriod = 1 minutes;
    // 
    uint256 public _releaseSupply;

    constructor(
        IERC20 token_,
        address[] memory beneficiaries_,
        uint256 releaseTime_
    ) {
        require(releaseTime_ > block.timestamp, "TokenTimelock: release time is before current time");
        _token = token_;
        _beneficiaries = beneficiaries_;
        _releaseTime = releaseTime_;
        _releaseSupply = _token.totalSupply()/(525600*_beneficiaries.length);

    }

    /**
     * @return the token being held.
     */
    function token() public view virtual returns (IERC20) {
        return _token;
    }


    /**
     * @return the time when the tokens are released.
     */
    function releaseTime() public view virtual returns (uint256) {
        return _releaseTime;
    }

    /**
     * @notice Transfers tokens held by timelock to beneficiary.
     */
    function release() public virtual {
        require(block.timestamp >= releaseTime(), "TokenTimelock: current time is before release time");

        
        uint256 balance = token().balanceOf(address(this));

        require(balance >= _releaseSupply*_beneficiaries.length, "TokenTimelock: less tokens to release");
        
        for( uint i =0; i<_beneficiaries.length;i++){
            token().safeTransfer(_beneficiaries[i], _releaseSupply);
        }
        _releaseTime = _releaseTime+_releasePeriod;
    }
}