// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract DynamicArray {
    uint[] public numbers ;

    function getLength() view public returns (uint) {
        return numbers.length ;
    }

    function addElement(uint element) public {
        numbers.push(element);
    }

    function getElement(uint index) public view returns(uint) {
        if(index < numbers.length) {
            return numbers[index] ;
        }
        return 0 ;
    }

    function popElement() public {
        numbers.pop();
    }

    function memoryArray() public pure {
        uint[] memory y = new uint[](3);
        y[0] = 1 ;
        y[1] = 2 ;
        y[2] = 3 ;

    }
}