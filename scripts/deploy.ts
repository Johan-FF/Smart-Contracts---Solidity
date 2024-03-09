import { ethers } from "hardhat";

async function main() {
  const ima = await ethers.deployContract("Ima", [10000]);

  await ima.waitForDeployment();

  console.log(`Deployed to ${ima.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
