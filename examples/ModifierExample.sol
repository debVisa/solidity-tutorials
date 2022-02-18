// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract Modifier_Example {

    address public owner ;
    uint public price ;

    constructor () {
        owner = msg.sender ;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


    function changePrice(uint _price) public onlyOwner {
        price = _price ;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}