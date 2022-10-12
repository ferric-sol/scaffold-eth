pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {

  mapping(address => uint256) public balances;

  struct userDetailsStruct {
    string name;
    uint256 age;
  }

  mapping(address => userDetailsStruct) public userDetails;

  function deposit(uint256 _amount) public {
      balances[msg.sender] = _amount;
  }

  function checkBalance() public view returns (uint256) {
    return balances[msg.sender];
  }

  function setUserDetails(string calldata name, uint256 age) public {
    userDetails[msg.sender].name = name;
    userDetails[msg.sender].age = age;
  }

  function getUserDetail() public view returns (userDetailsStruct memory) {
    return userDetails[msg.sender];
  }

}
