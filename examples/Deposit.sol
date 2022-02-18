// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Deposit {

    address public owner ;

    receive() external payable {}

    fallback() external payable {}

    constructor(){
        owner = msg.sender ;
    }


    function sendEther() public payable {

    }

    //return the balance of the contract
    function getBalance() public view returns(uint) {
        return address(this).balance ;
    }

    function transferEther(address payable recipient,uint amount) public returns(bool){
    require(owner == msg.sender,"Transfer Failed ,Your are not owner")
    if(amount <=getBalance()){
    recipient.transfer(amount);
    return true ;
    }else {
    return false ;
    }
    }
}