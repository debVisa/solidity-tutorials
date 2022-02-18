// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract MemoryExample {
    string[] public names = ["hello","world"] ;


    function A_memory() view public {
        string[]  memory s1 = names ;
        s1[0] = "Hi";
    }

    function B_Storage () public {
        string[] storage s2 = names ;
        s2[0] = "kill";
    }
}