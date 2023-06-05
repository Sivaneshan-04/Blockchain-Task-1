// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VoteSystem{

    address private manager;
    mapping (address =>uint256 ) private votes;
    address[] private voters;
    address[] private canditates;    

    //Assigning the admin address and the address of the canditates
    constructor(address cand1, address cand2){
        manager = msg.sender;
        canditates.push(cand1);
        canditates.push(cand2);
    }

    //this function returns the address of the canditates
    function showCanditates() public view returns(address[] memory){
        return canditates;
    }

    //Voters can vote using this function
    function enterVote(address candAddress) public{
        require(eligibilityCheck(msg.sender),"Sorry,You have already voted");
        voters.push(msg.sender);
        votes[candAddress]++;
    }

    //this function checks the eligibility of the canditates
    function eligibilityCheck(address checkAddress)internal view returns (bool){
        for(uint i=0; i<voters.length;i++){
            if(checkAddress == voters[i]){
                return false;
            }
        }
        return true;
    }

    //Admin can pick the winner using this function
    function pickWinner()public view returns(address){
        require(msg.sender == manager, "Only admin is allowed to pick the winner");

        if(votes[canditates[0]]>votes[canditates[1]]){
            return canditates[0];
        }
        // else if(votes[canditates[0]]==votes[canditates[1]]){
        //     return "Both have got equal votes";
        // }
        else{
            return canditates[1];
        }

    }    
}