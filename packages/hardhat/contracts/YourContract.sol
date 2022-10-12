pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {

  address public owner;

  uint private constant Fee = 2;

  mapping(address => uint256) public balances;

  struct userDetailsStruct {
    string name;
    uint256 age;
  }

  mapping(address => userDetailsStruct) public userDetails;

  constructor() {
        // Set the transaction sender as the owner of the contract.
        owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Not owner");
    // Underscore is a special character only used inside
    // a function modifier and it tells Solidity to
    // execute the rest of the code.
    _;
  }

  modifier onlyDepositor() {
    require(balances[msg.sender] > 0, "Not a previous depositor");
    _;
  }

  error AmountTooSmall();

  modifier checkFee(uint256 _amount) {
    if(Fee > _amount) {
      revert AmountTooSmall();
    }
    _;
  }


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

  function withdraw(uint256 _amount) public onlyOwner {
    balances[msg.sender] -= _amount;
  }

  function addFund(uint256 _amount) public onlyDepositor checkFee (_amount) { 
    balances[msg.sender] += _amount;
  }
}
