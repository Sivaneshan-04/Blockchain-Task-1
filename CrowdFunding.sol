// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract Crowdfunding{

    address payable public admin;
    uint256 public maxAmount;
    uint256  public deployTime;

    mapping (address =>uint256) private amountPaid;
    address payable[] private people;
    uint256 private totalBalance;


    constructor(uint256 Amount){
        admin = payable(msg.sender);
        maxAmount = Amount * 1 ether;
        deployTime = block.timestamp;
    }

    function payAmount() public payable{
        people.push(payable(msg.sender));
        amountPaid[msg.sender]+= msg.value;
        totalBalance+= msg.value;

        if(totalBalance >= maxAmount){
            admin.transfer(totalBalance);
            totalBalance=0;
        }
    }

    function timeChecker() public payable{
        if(block.timestamp- deployTime >= 172800){
            for(uint256 i=0;i<people.length;i++){
                people[i].transfer(amountPaid[people[i]]);
            }
        }
    }

    function transferAmount() public payable{
        require(msg.sender == admin, "Only admin can transfer the amount");
        admin.transfer(totalBalance);
        totalBalance=0;

    }
}