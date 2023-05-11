// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract TaskContract {

    event AddTask(address recipient, uint taskId);
    event DeleteTask(uint taskId, bool isDeleted);
    
    struct Task{
        uint256 id;
        string taskText;
        bool isDeleted;
    }

    Task[] private tasks;

    mapping(uint256 => address) taskToOwner;

    function addTask(string memory taskText, bool isDeleted) external {
        uint taskId = tasks.length;
        tasks.push(Task(taskId, taskText, isDeleted));
        taskToOwner[taskId] = msg.sender;
        emit AddTask(msg.sender, taskId);
    }

    function deleteTask(uint taskId, bool isDeleted) public{
       if(taskToOwner[taskId] == msg.sender){
           tasks[taskId].isDeleted = isDeleted;
           emit DeleteTask(taskId, isDeleted);
       }
    }

    function getTasks() public view returns(Task[] memory){
        Task[] memory temp = new Task[](tasks.length);
        uint counter = 0; // number of tasks owned by user
        for(uint i = 0; i < tasks.length; i++){
            if(taskToOwner[i] == msg.sender && tasks[i].isDeleted == false){
                temp[counter] = tasks[i];
                counter++;
            }
        }

        Task[] memory result = new Task[](counter);
        for(uint i = 0; i < counter; i++){
            result[i] = temp[i];
        }

        return result;
    }


    function getTasksLength() public view returns(uint){
        return tasks.length;
    }
}