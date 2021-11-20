// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Token is ERC20{
    // mint 100 million tokens    
    constructor() 
    ERC20("Token","TKN"){
        _mint(msg.sender,1e26);
    }
}

