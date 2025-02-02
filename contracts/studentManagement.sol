// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

contract StudentManagement {
    address owner;
    mapping(uint256 => Student) students;
    uint8 studentId = 0;

    constructor(){
        owner = msg.sender;
    }

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

    modifier OwnerOnly {
        require(msg.sender == owner, "Only Admin Can Perform this action");
        _;
    }


    function registerStudent(
        string memory _name,
        string memory _class,
        uint8 _age,
        Gender _gender
    ) external OwnerOnly {
        require(_age > 3 , 'Age must be greater than 3');
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

    function getStudent(
        uint8 _studentId
    ) public view returns (Student memory student_) {
        return student_ = students[_studentId];
    }

    function getStudents() public view returns (Student[] memory students_) {
        students_ = new Student[](studentId);
        for (uint8 i = 1; i <= studentId; i++) {
            students_[i - 1] = students[i];
        }
        return students_;
    }

    function deleteStudent(uint8 _studentId) external {
        require(bytes(students[_studentId].name).length != 0, "Student does not exist");
        delete students[_studentId];
        studentId--;
    }

    function updateStudentDetails(
        uint8 _studentId,
        string memory _name,
        string memory _class,
        uint8 _age
    ) external {
        require(bytes(students[_studentId].name).length != 0, "Student does not exist");
        students[_studentId].name = _name;
        students[_studentId].class = _class;
        students[_studentId].age = _age;
    }

    function getTotalStudentCount()
        external
        view
        returns (uint8 totalStudents)
    {
        totalStudents = studentId;
    }
}
