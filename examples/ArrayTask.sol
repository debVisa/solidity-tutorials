// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract ArrayTask {

    uint[] public numbers = [10,20] ;


    function test() public {
        numbers.pop();
        numbers.push(100);
        numbers[1] = 66 ;
    }
}