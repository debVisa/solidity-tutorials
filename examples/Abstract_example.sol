pragma solidity 0.8.0;

abstract contract Parent {
    address public owner ;

    constructor() {
        owner = msg.sender ;
    }

    function set_x(int x)  public virtual;
}

contract child is Parent {
    int public y ;

    function set_x(int _x) public override {
        y = _x ;
    }
}