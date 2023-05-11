// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract TaskContractMain {

    event AddTask(address recipient, uint taskId);
    event DeleteTask(uint taskId, bool isDeleted);
    event UpdateTask(uint taskId, string taskText);
    
    struct Task{
        uint256 id;
        string taskText;
        bool isDeleted;
    }


    mapping(address => Task[]) private users;

    function addTask(string memory taskText, bool isDeleted) external {
        uint id = users[msg.sender].length;
        Task memory newTask  = Task(id, taskText, isDeleted);
        users[msg.sender].push(newTask);
        emit AddTask(msg.sender, id);
    }

    function deleteTask(uint taskId, bool isDeleted) public{
        uint tasksLength = users[msg.sender].length;
        for(uint i = 0; i < tasksLength; i++){
            if(users[msg.sender][i].id == taskId){
                users[msg.sender][i].isDeleted = isDeleted;
                emit DeleteTask(taskId, isDeleted);
            }
        }
    }

    function updateTask(uint taskId, string memory taskText) public{
        users[msg.sender][taskId].taskText = taskText;
        emit UpdateTask(taskId, taskText);
    }

    function getTasks() public view returns(Task[] memory){
        Task[] memory tasks =  users[msg.sender];
        Task[] memory currentTasks = new Task[](tasks.length);
        uint counter = 0;
        for(uint i = 0; i < tasks.length; i++){
            if(tasks[i].isDeleted == false){
                currentTasks[counter] = tasks[i];
                counter++;
            }
        }

        Task[] memory result = new Task[](counter);
        for(uint i = 0; i < counter; i++){
            result[i] = currentTasks[i];
        }
        return result;
    }

    function getTasksLength() public view returns(uint){
        return users[msg.sender].length;
    }
}