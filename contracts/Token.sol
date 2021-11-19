// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Token is ERC20{

    uint256 public totalSupply = 1e26;
    
    constructor(
        address _vesting
    ) 
    ERC20("Token","TKN"){
        _mint(_vesting,_totalSupply);
    }
}

