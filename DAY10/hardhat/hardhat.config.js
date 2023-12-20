require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const RPC_URL = process.env.RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const API = process.env.ETHERSCAN_API_KEY;
module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: RPC_URL,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: API,
  },
};
