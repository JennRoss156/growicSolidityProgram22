pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol


/**
 * @title StudentRegister
 * @notice StudentRegister contract is a contract to register the marks of a student and calculates his percentage
*/

contract StudentRegister{

/**
 *  owner is a state variable
 */
    address public owner;
  
  /**
   * mapping address as key to struct student with mapping name students
   */
    mapping (address=>student)students;
    
    /**
     *  assigning the contract deployer as the owner
     */
    constructor() public {
        owner=msg.sender;
    }
    
    /**
     * a modifier onlyOwner is created to limit the access to function register to contract deployer
     */
    modifier onlyOwner {
        require(msg.sender==owner);
        _;
    }
    /**
     *  a struct student is defined
     */
    struct student{
        
        address studentId;
        string  name;
        string course;
        uint256 mark1;
        uint256 mark2;
        uint256 mark3;
        uint256 totalMarks;
        uint256 percentage;
        bool isExist;
        
    }
    /**
     * @notice function to register studentid,name,course and marks
     * @param studentId is student's ethereum address
     * @param name student's name
     * @param course student's course
     * @param mark1 student's mark's
     */
    function register(address studentId,string memory name,string memory course,uint256 mark1,uint256 mark2,uint256 mark3) public onlyOwner {
            /**
             *require statment to block multiple entry
             */
            require(students[studentId].isExist==false,"ha.. ha... Fraud Not Possible,student details already registered and cannot be altered");
            
            uint256 totalMarks;
            uint256 percentage;
            /**
             * calculating totalMarks and percentage
             */
            
            totalMarks=(mark1+mark2+mark3);
            
            percentage=(totalMarks/3);
            
            /**
             *  assigning the student details to a key (studentId)
             */
            students[studentId]=student(studentId,name,course,mark1,mark2,mark3,totalMarks,percentage,true);
    }
    
    /**
     * @notice function to get the details of a student when studentId is given
     */
            
    function getStudentDetails(address studentId) public view returns (address,string memory,string memory,uint256,uint256){
        
        /**
         *  returning studentId,name,course,totalMarks and percentage of student to corresponding key
         */ 
        return(students[studentId].studentId,students[studentId].name,students[studentId].course,students[studentId].totalMarks,students[studentId].percentage);
    }
}
