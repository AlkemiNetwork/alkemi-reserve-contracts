var AlkemiNetwork = artifacts.require("./AlkemiNetwork.sol");

async function doDeploy(deployer) {
    await deployer.deploy(AlkemiNetwork);
}

module.exports = (deployer) => {
    deployer.then(async() => {
        await doDeploy(deployer);
    });
}