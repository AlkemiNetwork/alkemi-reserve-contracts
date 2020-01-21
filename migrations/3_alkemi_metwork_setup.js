var TokenMock = artifacts.require("TokenMock.sol");
var AlkemiOracle = artifacts.require("AlkemiOracle.sol");
var OracleGuard = artifacts.require("OracleGuard.sol");
var AlkemiNetwork = artifacts.require("./AlkemiNetwork.sol");

const deploymentConfig = require("./deployment-config.json");

module.exports = async (deployer, network, accounts) => {
    if (network == "development") {
        const alkemiToken = await TokenMock.deployed();
        const alkemiOracle = await AlkemiOracle.deployed();
        const oracleGuard = await OracleGuard.deployed();
        const alkemiNetwork = await AlkemiNetwork.deployed();
    
        await oracleGuard.setOracleContract(alkemiOracle.address);
        await oracleGuard.setTokenContract(alkemiToken.address);
        await oracleGuard.authContract([alkemiNetwork.address]);
        await alkemiNetwork.setAlkemiOracle(alkemiOracle.address);    
    }
    else if (network == "rinkeby") {
        const alkemiOracle = await AlkemiOracle.deployed();
        const oracleGuard = await OracleGuard.deployed();
        const alkemiNetwork = await AlkemiNetwork.deployed();
    
        await oracleGuard.setOracleContract(alkemiOracle.address);
        await oracleGuard.setTokenContract(deploymentConfig.RINKEBY.ALKEMI_TOKEN);
        await oracleGuard.authContract([alkemiNetwork.address]);
        await alkemiNetwork.setAlkemiOracle(alkemiOracle.address); 
    }
    else if (network == "kovan") {
        const alkemiOracle = await AlkemiOracle.deployed();
        const oracleGuard = await OracleGuard.deployed();
        const alkemiNetwork = await AlkemiNetwork.deployed();
    
        await oracleGuard.setOracleContract(alkemiOracle.address);
        await oracleGuard.setTokenContract(deploymentConfig.KOVAN.ALKEMI_TOKEN);
        await oracleGuard.authContract([alkemiNetwork.address]);
        await alkemiNetwork.setAlkemiOracle(alkemiOracle.address); 
    }
    else {
        const alkemiOracle = await AlkemiOracle.deployed();
        const oracleGuard = await OracleGuard.deployed();
        const alkemiNetwork = await AlkemiNetwork.deployed();
    
        await oracleGuard.setOracleContract(alkemiOracle.address);
        await oracleGuard.setTokenContract(deploymentConfig.MAINNET.ALKEMI_TOKEN);
        await oracleGuard.authContract([alkemiNetwork.address]);
        await alkemiNetwork.setAlkemiOracle(alkemiOracle.address); 
    }

}