import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";

const config = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    polygon: {
      url: process.env.POLYGON_RPC_URL,
      chainId: Number(process.env.POLYGON_CHAIN_ID) || 80001,
      // gasPrice: 20000000000,
      accounts:
        process.env.WALLET_PRIVATE_KEY !== undefined
          ? [process.env.WALLET_PRIVATE_KEY]
          : [],
    },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: process.env.POLYGON_API_KEY as string,
      polygon: process.env.POLYGON_API_KEY as string,
    },
  },
};

export default config;
