// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;


interface  First {

    function setName(string memory name) external ;

}

contract Second is First {
    string public name ;
    function setName(string memory _nm) public override{
        name = _nm ;
    }

}

contract Base{
    int public x ;
    address public owner ;

    constructor() {
        x = 5 ;
        owner = msg.sender ;
    }

    function setX(int _x) public {
        x = _x;
    }


}

contract ChildContract is Base {
    int public y ;
}


