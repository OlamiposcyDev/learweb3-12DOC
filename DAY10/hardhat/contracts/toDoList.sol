// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ToDoList {
    address public owner;

    struct Task {
        string description;
        bool isCompleted;
    }

    mapping(uint256 => Task) public tasks;
    uint256 public taskCount;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner Can Make a Change");
        _;
    }

    modifier taskExist(uint256 _taskId) {
        require(_taskId < taskCount, "Task has not been created");
        _;
    }

    event TaskCreated(uint256 taskId, string description);
    event TaskUpdated(uint256 taskId, string newDescription);
    event TaskCompleted(uint256 taskId);
    event TaskDeleted(uint256 taskId);

    constructor() {
        owner = msg.sender;
    }

    function createTask(string memory _description) public onlyOwner {
        tasks[taskCount] = Task(_description, false);
        emit TaskCreated(taskCount, _description);
        taskCount++;
    }

    function updateTask(
        uint256 _taskId,
        string memory _newDescription
    ) public onlyOwner taskExist(_taskId) {
        // require(_taskId < taskCount, "Task has not been created");

        tasks[_taskId].description = _newDescription;
        emit TaskUpdated(_taskId, _newDescription);
    }

    function markTaskComplete(
        uint256 _taskId
    ) public onlyOwner taskExist(_taskId) {
        //require(_taskId < taskCount, "Task has not been created");
        tasks[_taskId].isCompleted = true;
        emit TaskCompleted(_taskId);
    }

    function deleteTask(uint256 _taskId) public onlyOwner taskExist(_taskId) {
        // require(_taskId < taskCount, "Task has not been created");

        delete tasks[_taskId];
        emit TaskDeleted(_taskId);
    }

    function viewTask(
        uint256 _taskId
    ) public view taskExist(_taskId) returns (string memory, bool) {
        // require(_taskId < taskCount, "Task has not been created");

        Task memory task = tasks[_taskId];
        return (task.description, task.isCompleted);
    }
}
