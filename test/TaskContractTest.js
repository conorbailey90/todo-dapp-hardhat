const {expect} = require('chai');
const {ethers, tasks} = require('hardhat');
const { task } = require('hardhat/config');

describe('Task Contract', () => {
  let TaskContract;
  let taskContract;
  let owner;

  const NUM_TOTAL_TASKS = 5;
  let totalTasks;

  beforeEach(async () => {
    TaskContract = await ethers.getContractFactory('TaskContract');
    [owner] = await ethers.getSigners();
    taskContract = await TaskContract.deploy();

    totalTasks = [];

    for(let  i = 0; i < NUM_TOTAL_TASKS; i++){
      let task = {
        "taskText": `Task ${i}`,
        "isDeleted:": false
      }
      await taskContract.addTask(task.taskText, task.isDeleted);
      totalTasks.push(task);
    }
 

  })

  describe('Add Task', async () => {
    it('Should emit add task event', async () => {
      let task = {
        "taskText": `New Task`,
        "isDeleted": false
      }
  
      expect(await taskContract.addTask(task.taskText, task.isDeleted)).to.emit('AddTask').withArgs(owner.address, NUM_TOTAL_TASKS);
   
    })
  })

  describe('Get tasks', async () => {
    it('Should get all users tasks', async () => {
      let task = {
        "taskText": `New`,
        "isDeleted": false
      }
    
      await taskContract.addTask(task.taskText, task.isDeleted)
      let results = await taskContract.getTasks();
      expect(results.length).to.equal(6)
    })
  })

  describe('Delete tasks', async () => {
    it('Should delete first task', async () => {
    
      await taskContract.deleteTask(0, true);
      let results = await taskContract.getTasks();
    
      expect(results[0][1]).to.equal('Task 1')
    })
  })
})
