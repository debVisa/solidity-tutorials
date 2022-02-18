// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0 ;

contract Property {
    int public value ;
    uint256 private price ;
    address public owner ;
    // this is constructor
    constructor() {
        price = 0 ;
        owner = msg.sender ;
    }

    function setValue(int _val) public {
        value = _val ;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function changeOwner(address _owner) public onlyOwner {
        owner = _owner ;
    }

    /*
    setprice function 
    */

    function setPrice(uint256 _price) public {
        price = _price ;
    }

    /// @notice returns the price of the property
    function getPrice() view public returns (uint256) {
        return price ;
    }

    event ownerChanged(address owner) ;


}