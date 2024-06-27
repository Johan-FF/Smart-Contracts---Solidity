import { run } from "hardhat";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction, DeployResult } from "hardhat-deploy/dist/types";

const deployLock: DeployFunction = async function (
  hre: HardhatRuntimeEnvironment
) {
  const { getNamedAccounts, deployments } = hre;
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();

  log("------------------------------------");
  log("Deploying Ima \n");
  const ima: DeployResult = await deploy("Ima", {
    from: deployer,
    args: [1000], //MaxSupply
    log: true,
  });

  log("------------------------------------");
  log("Verifying Ima \n");
  await run("verify:verify", {
    address: ima.address,
    constructorArguments: [1000],
  });
};

export default deployLock;
