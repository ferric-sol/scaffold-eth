pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {
  // Payable address can receive Ether
  address payable public owner;

  // Payable constructor can receive Ether
  constructor() payable {
    owner = payable(msg.sender);
  }

  mapping(address => uint256) public balances;

  // Function to deposit Ether into this contract.
  // Call this function along with some Ether.
  // The balance of this contract will be automatically updated.
  function deposit() public payable {
    balances[msg.sender] += msg.value;
  }

  function checkBalance() public view returns (uint256) {
    return balances[msg.sender];
  }

  // Fallback function must be declared as external.
  fallback() external payable {
    deposit();
  }

  // Receive is a variant of fallback that is triggered when msg.data is empty
  receive() external payable {
    deposit();
  } 

}
