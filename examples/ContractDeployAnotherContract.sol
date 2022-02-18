// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;



contract ContractA {

    address public owner ;


    constructor(address eoa){
        owner = eoa;
    }
}

contract Creator {
    address public creatorAddress ;
    ContractA[] public allAContracts ;

    constructor() {
        creatorAddress = msg.sender;
    }

    function deployContractA()  public {
        ContractA a_instance = new ContractA(msg.sender);
        allAContracts.push(a_instance);
    }
}