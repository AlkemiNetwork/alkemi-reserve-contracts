var TokenMock = artifacts.require("TokenMock.sol");
var AlkemiOracle = artifacts.require("AlkemiOracle.sol");
var OracleGuard = artifacts.require("OracleGuard.sol");
var AlkemiNetwork = artifacts.require("./AlkemiNetwork.sol");

const deploymentConfig = require("./deployment-config.json");

module.exports = async (deployer, network, accounts) => {
    if (network == "development") {
        await deployer.deploy(TokenMock, "Alkemi Token", "ALK", 18);

        await deployer.deploy(AlkemiNetwork);
        await deployer.deploy(OracleGuard, deploymentConfig.DEVCHAIN.MIN_TOKEN);
        await deployer.deploy(AlkemiOracle, OracleGuard.address, AlkemiNetwork.address);
    }
    else {
        await deployer.deploy(AlkemiNetwork);
        await deployer.deploy(OracleGuard, deploymentConfig.PRODUCTION.MIN_TOKEN);
        await deployer.deploy(AlkemiOracle, OracleGuard.address, AlkemiNetwork.address);
    }
}
