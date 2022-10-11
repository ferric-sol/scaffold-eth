pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {

  address public owner;

  struct StudentDetailsStruct {
    string firstname;
    string lastname;
    string grade;
    bool exists;
  }

  mapping(address => StudentDetailsStruct) public studentDetails;

  // Modifier to check that the caller is the owner of
  // the contract.
  modifier onlyOwner() {
      require(msg.sender == owner, "Not owner");
      // Underscore is a special character only used inside
      // a function modifier and it tells Solidity to
      // execute the rest of the code.
      _;
  }

  constructor() {
    // Set the transaction sender as the owner of the contract.
    owner = msg.sender;
  }

  function getDetails(address StudentId) public view returns (StudentDetailsStruct memory) {
    // Mapping always returns a value.
    // If the value was never set, it will return the default value.
    return studentDetails[StudentId];
  }

  function register(address StudentId, string calldata firstname, string calldata lastname, string calldata grade) public onlyOwner {
    require(!studentDetails[StudentId].exists, 'StudentId can only register once');

    StudentDetailsStruct memory tempStudent; 

    tempStudent.firstname = firstname;
    tempStudent.lastname = lastname;
    tempStudent.grade = grade;
    tempStudent.exists = true;

    studentDetails[StudentId] = tempStudent;
  }

}
