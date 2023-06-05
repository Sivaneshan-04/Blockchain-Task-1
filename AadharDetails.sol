// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract AadhaarDetails{
    mapping(uint256 => Details)private People;

    struct Details{
        string DOB;
        string name;
        string Address;
        uint256 aadharNum;
        address walletAddress;
    }

    //Users enter their data in this function
    function enterData(string memory dob, string memory name, string memory Address, uint256 aadharNum, address wallet ) public{
        People[aadharNum]= Details(dob, name, Address,aadharNum, wallet);
    }

    //Users can check the details after entering their aadhar number
    function getData(uint256 aadharNum) public view returns( Details memory){
        return People[aadharNum];
    } 
}
