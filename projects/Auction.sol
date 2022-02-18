// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;


contract AuctionCreator {
    Auction[] public auctions ;

    function createAuction() public {
        Auction auction = new Auction(msg.sender);
        auctions.push(auction);
    }
}

contract Auction {
    address payable public owner ;
    uint public startBlock ;
    uint public endBlock ;
    string public ipfsHash ;

    enum State {Started,Running,Ended,Canceled}
    State public auctionState ;

    uint public highestBindingBid ;
    address payable public highestBidder ;

    mapping(address => uint) public bids ;
    uint bidIncreament ;
    //the owner can finalize the auction and get the highestBindingBid only once
    bool public ownerFinalized = false ;

    constructor(address eoa) {
        owner = payable(eoa);
        startBlock = block.number ;
        endBlock = startBlock + 3 ;
        auctionState = State.Running ;
        bidIncreament = 100 ;
    }

    modifier notOwner() {
        require(msg.sender != owner);
        _;
    }

    modifier dateWithin() {
        require(block.number >= startBlock && block.number <= endBlock);
        _;
    }

    function min(uint a ,uint b) pure internal returns(uint) {
        if(a <=b){
            return a ;
        }else {
            return b ;
        }
    }

    function placeBid() public payable notOwner dateWithin {
        require(auctionState == State.Running);
        require(msg.value >= 100);

        uint currentBid = bids[msg.sender] + msg.value ;
        require(currentBid > highestBindingBid);
        bids[msg.sender] = currentBid ;

        if(currentBid <= bids[highestBidder]) {
            highestBindingBid = min(currentBid + bidIncreament,bids[highestBidder]);
        }else {
            highestBindingBid = min(currentBid, bids[highestBidder] + bidIncreament);
            highestBidder = payable(msg.sender);
        }
    }


    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function cancelAuction() public onlyOwner {
        auctionState = State.Canceled;
    }

    function finalizeAuction() public{
        // the auction has been Canceled or Ended
        require(auctionState == State.Canceled || block.number > endBlock);

        // only the owner or a bidder can finalize the auction
        require(msg.sender == owner || bids[msg.sender] > 0);

        // the recipient will get the value
        address payable recipient;
        uint value;

        if(auctionState == State.Canceled){ // auction canceled, not ended
            recipient = payable(msg.sender);
            value = bids[msg.sender];
        }else{// auction ended, not canceled
            if(msg.sender == owner && ownerFinalized == false){ //the owner finalizes the auction
                recipient = owner;
                value = highestBindingBid;

                //the owner can finalize the auction and get the highestBindingBid only once
                ownerFinalized = true;
            }else{// another user (not the owner) finalizes the auction
                if (msg.sender == highestBidder){
                    recipient = highestBidder;
                    value = bids[highestBidder] - highestBindingBid;
                }else{ //this is neither the owner nor the highest bidder (it's a regular bidder)
                    recipient = payable(msg.sender);
                    value = bids[msg.sender];
                }
            }
        }

        // resetting the bids of the recipient to avoid multiple transfers to the same recipient
        bids[recipient] = 0;

        //sends value to the recipient
        recipient.transfer(value);

    }

}