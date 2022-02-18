// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract BytesAndStrings {
    bytes public byteVar = 'hello' ;
    string public stringVar = "hi";

    function addElement() public {
        byteVar.push('x');
    }

    function getLength() public view returns(uint) {
        return byteVar.length ;
    }
}