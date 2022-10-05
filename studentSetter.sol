// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * @title Student registering contract
 * @author Famus
 * @notice A contract that allow a predefined owner to register their name and marks based on their eth address
 */

contract studentSetter {
    address public owner;

    // students marks are out of 20
    struct Student {
        string studname;
        uint field1; //mark for subject1
        uint field2; //mark for subject2
        uint average; //average
        uint exist; //set to 1 once the student is registered, 0 otherwise
    }

    mapping(address => Student) students;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "wrong owner, try again");
        _;
    }

    function register(
        address _studentId,
        string memory _studname,
        uint _field1,
        uint _field2
    ) external onlyOwner {
        require(students[_studentId].exist == 0, "Id already registered");
        uint _average = (_field1 + _field2) / 2;
        Student memory student = Student(
            _studname,
            _field1,
            _field2,
            _average,
            1
        );
        students[_studentId] = student;
    }

    function getStudentDetails(address _studentId)
        external
        view
        returns (
            string memory studname,
            uint field1,
            uint field2,
            uint average
        )
    {
        require(students[_studentId].exist == 1, "Id not registered");
        Student memory _student = students[_studentId];
        return (
            _student.studname,
            _student.field1,
            _student.field2,
            _student.average
        );
    }
}
