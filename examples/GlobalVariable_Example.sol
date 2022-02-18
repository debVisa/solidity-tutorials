// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract GlobalVariable {
    address public owner ;
    uint public sentValue ;
    uint public block_number = block.number ;
    uint public difficulty = block.difficulty;
    uint public gaslimit = block.gaslimit ;

    constructor() {
        owner = msg.sender ;
    }

    function sendEther() payable public {
        sentValue = msg.value ;
    }

    function getBalance() view public returns(uint) {
        return address(this).balance ;
    }

    function howMuchGas() view public returns(uint) {
        uint start = gasleft();
        uint j = 1 ;
        for(uint i =1 ; i <100 ;i ++) {
            j*=i ;
        }
        uint end = gasleft();
        return (start-end);
    }
}