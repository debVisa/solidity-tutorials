// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

    struct Instructor {
        uint age ;
        string name ;
        address add ;
    }

contract Academy {
    Instructor public academyInstructor ;
    enum State  { OPEN,CLOSED,UNKNOWN}
    State public state = State.OPEN ;

    constructor(uint _age,string memory _name) {
        academyInstructor.age = _age ;
        academyInstructor.name = _name ;
        academyInstructor.add = msg.sender ;
    }

    function changeInstructor(uint _age ,string memory _name ,address add) public {
        if(State.OPEN == state) {
            Instructor memory myInstructor = Instructor({
            age : _age ,
            name : _name ,
            add : add
            });
            academyInstructor = myInstructor ;
        }
    }
}