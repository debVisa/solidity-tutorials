// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0 ;

contract StateVariableExample {
    int public price = 100 ;
    string constant public location = "SINGAPORE" ;

    // pure means it wont save into blockchain

    function getVariables() public pure returns(int) {
        int x = 5 ;
        x = x*2 ;
        string memory s = "abc";
        return x ;
    }
}
