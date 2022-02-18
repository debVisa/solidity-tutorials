// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A {
    int public x = 10 ;
    int y = 20 ;


    function getYValue() public view returns(int){
        return y ;
    }

    //can be called inside contract

    function privateFunction() private view returns(int) {
        return x ;
    }

    function callPrivateFunction() public view returns(int){
        return privateFunction();
    }
    // can be accessed within contract and as well as from other contract

    function internalFunction() internal  view returns(int){
        return x ;
    }

    // can be called from outside of contract

    function externalFunction() external view returns(int){
        return x ;
    }

    function pureFunction() public pure returns(int){
        int b ;
        return b ;
        // b  = externalFunction(); // its external,we cant call
    }
}

contract B is A {
    int public xx = internalFunction();
    //int public yy = privateFunction(); we cant call private function from another contract

    // int public zz = externalFunction();
}

contract C  {
    A public contract_a = new A();
    int public xx = contract_a.externalFunction();

}