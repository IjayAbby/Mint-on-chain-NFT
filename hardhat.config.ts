require("@nomicfoundation/hardhat-toolbox");
require ("dotenv").config();

const { API_KEY,ALCHEMY_POLYGON_API_KEY_URL, ACCOUNT_PRIVATE_KEY, POLYGON_SCAN_API_KEY} = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  defaultNetwork: "mumbai",
  networks: {
    hardhat: {},
    mumbai: {
      url: ALCHEMY_POLYGON_API_KEY_URL,
      accounts: [ `0x${ACCOUNT_PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: process.env.POLYGON_SCAN_API_KEY,
  },
  
};