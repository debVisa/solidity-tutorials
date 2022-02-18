// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address payable[] public  players ;
    address public manager ;

    constructor() {
        manager = msg.sender;
        players.push(payable(manager));
    }

    receive() external payable {
        require(msg.sender != manager);
        require(msg.value == 0.1 ether);
        players.push(payable(msg.sender));
    }

    function getBalance() view public returns(uint){
        require(msg.sender == manager);
        return address(this).balance ;
    }

    function random() view public returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function pickWinner()  public {
        require(msg.sender == manager);
        uint randomNumber = random() ;
        uint index = randomNumber % players.length;
        address payable winner =  players[index];
        uint managerPercentage = (getBalance() * 10)/100 ; //manager fee
        uint winnerPercentage = getBalance() -  managerPercentage ;
        winner.transfer(winnerPercentage);
        payable(manager).transfer(managerPercentage);
        players = new address payable[](0);
        players.push(payable(manager));
    }
}