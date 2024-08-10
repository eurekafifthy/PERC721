const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const AneemaCollection = await ethers.getContractFactory("AneemaCollection");
    const aneemaCollection = await AneemaCollection.deploy();

    await aneemaCollection.waitForDeployment();
    console.log("AneemaCollection deployed to:", aneemaCollection.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
