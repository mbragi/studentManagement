// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract StudentManagement {
    mapping(uint256 => Student) students;
    uint8 studentId = 0;

    event CreatedStudent(
        string indexed name,
        string indexed class,
        uint8 indexed age
    );

    enum Gender {
        Male,
        Female
    }

    struct Student {
        string name;
        string class;
        uint8 age;
        Gender gender;
    }

    function registerStudent(
        string memory _name,
        string memory _class,
        uint8 _age,
        Gender _gender
    ) external {
        Student memory student = Student({
            name: _name,
            age: _age,
            gender: _gender,
            class: _class
        });

        studentId++;

        students[studentId] = student;

        emit CreatedStudent(_name, _class, _age);
    }

    function getStudent(uint8 _studentId) public pure {}

    function getStudents() public pure {}

    function deleteStudent(uint8 _studentId) external {}

    function updateStudentDetails(
        uint8 _studentId,
        string memory _name,
        string memory _class,
        uint8 _age
    ) external {}

    function getTotalStudentCount() external view returns (uint256) {}
}
