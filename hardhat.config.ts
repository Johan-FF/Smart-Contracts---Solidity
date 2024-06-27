import * as dotenv from "dotenv";
dotenv.config();
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";
import "hardhat-deploy";

const { ARBITRUM_SEPOLIA_RPC_URL, ARBISCAN_API_KEY, WALLET_PRIVATE_KEY } =
  process.env;

if (!ARBITRUM_SEPOLIA_RPC_URL || !ARBISCAN_API_KEY || !WALLET_PRIVATE_KEY) {
  throw new Error(
    "Please set ARBITRUM_SEPOLIA_RPC_URL, ARBISCAN_API_KEY and WALLET_PRIVATE_KEY in .env file."
  );
}

const SOLIDITY_SETTINGS = {
  optimizer: {
    enabled: true,
    runs: 200,
  },
};

const ACCOUNTS = [WALLET_PRIVATE_KEY];

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  defaultNetwork: "arbitrumSepolia",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    arbitrumSepolia: {
      url: ARBITRUM_SEPOLIA_RPC_URL,
      chainId: 421614,
      accounts: ACCOUNTS,
    },
  },
  etherscan: {
    apiKey: ARBISCAN_API_KEY,
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
};

export default config;
