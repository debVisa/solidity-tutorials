--
// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;


contract CrowdFunding {

    mapping( address => uint) contributors ;

    address public admin ;
    uint public noOfContributors ;
    uint public minimumContribution ;
    uint public deadline ;
    uint public goal ;
    uint public raisedAmount ;

    //spending request

    struct Request {
        string description ;
        address payable recipient ;
        uint value ;
        bool completed ;
        uint noOfVoters ;
        mapping(address => bool) voters ;
    }

    // mapping of spending requests
    // the key is the spending request number (index) - starts from zero
    // the value is a Request struct
    mapping(uint => Request) public requests ;
    uint noOfRequests ;






    constructor(uint _goal,uint _deadline){
        admin = msg.sender ;
        goal = _goal ;
        deadline = block.timestamp + _deadline ;
        minimumContribution = 100 wei ;
    }
    // events to emit
    event ContributeEvent(address _sender, uint _value);
    event CreateRequestEvent(string _description, address _recipient, uint _value);
    event MakePaymentEvent(address _recipient, uint _value);


    function contribute() public payable {
        require(block.timestamp <= deadline ,"deadline has passed");
        require(msg.value>=minimumContribution , "Min contribution not met");

        if(contributors[msg.sender] == 0) {
            noOfContributors++ ;
        }
        contributors[msg.sender] += msg.value ;
        raisedAmount+=msg.value ;
        emit ContributeEvent(msg.sender, msg.value);
    }

    receive () payable external {
        contribute() ;
    }

    function getBalance() view public returns(uint) {
        return address(this).balance ;
    }

    function getRefund() public {
        require(block.timestamp > deadline && raisedAmount < goal);
        require(contributors[msg.sender]>0);

        address payable recipient = payable(msg.sender);
        recipient.transfer(contributors[msg.sender]);
        contributors[msg.sender] = 0 ;
    }

    function createRequest(string memory description,address payable _recipient,uint _value) public {
        require(msg.sender == admin);
        Request storage newRequest = requests[noOfRequests];
        noOfRequests++;
        newRequest.description = description ;
        newRequest.recipient = _recipient;
        newRequest.value = _value ;
        newRequest.completed = false ;
        newRequest.noOfVoters = 0 ;
        emit CreateRequestEvent(description, _recipient, _value);
    }

    function voteRequest(uint _requestNo) public {
        require(contributors[msg.sender]> 0, "You must be a contributor");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender] == false,"You have already voted");
        thisRequest.voters[msg.sender] = true ;
        thisRequest.noOfVoters++ ;
    }

    function makePayment(uint _requestNo) public {
        require(msg.sender == admin && raisedAmount >=goal);
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed == false ," The request has been completed");
        require(thisRequest.noOfVoters > noOfContributors  / 2);
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true ;
        emit MakePaymentEvent(thisRequest.recipient, thisRequest.value);
    }

}