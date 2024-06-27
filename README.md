# Random Avatar Generator

This project is a smart contract built with Hardhat and TypeScript. The smart contract creates URLs that return pseudo-random avatars.

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```

## Introduction

The Random Avatar Generator is a blockchain-based application that generates unique avatar URLs using a smart contract. The avatars are created pseudo-randomly, ensuring a diverse range of avatar designs.

You can see the contract in: [Arbiscan - Arbitrum Sepolia](https://sepolia.arbiscan.io/address/0x2a3ba21125e3992cD6fbcf6F23913A870CD08C08#code)

## Installation

To get started with the project, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/Johan-FF/Smart-Contracts---Solidity.git
   cd Smart-Contracts---Solidity
   ```

2. Install the dependencies:
   ```bash
   npm install
   ```

## Usage

You need to set the value of the variables in the .env file.

1. Test the smart contracts:

   ```bash
   npm run test
   ```

2. Compile the smart contracts:

   ```bash
   npm run compile
   ```

3. Init a node:

   ```bash
   npm run chain
   ```

4. Deploy in local:

   ```bash
   npm run deploy:local
   ```

5. Deploy in ArbitrumSepolia:
   ```bash
   npm run deploy:arbitrumSepolia
   ```

## Contributing

Contributions are welcome! If you have any suggestions or improvements, please create a pull request or open an issue.
