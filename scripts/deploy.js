const {ethers} = require('hardhat');

const main = async () => {
  const contractFactory = await ethers.getContractFactory('TaskContractMain');
  const contract = await contractFactory.deploy();
  await contract.deployed();
  console.log(`Contract deployed to ${contract.address}`);
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  }catch(err){
    console.log(err);
    process.exit(1);
  }
}

runMain();

// npx hardhat run scripts/deploy.js --network goerli