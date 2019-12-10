var LiquidityReserveManager = artifacts.require("./LiquidityReserveManager.sol");

async function doDeploy(deployer) {
    await deployer.deploy(LiquidityReserveManager);
}

module.exports = (deployer) => {
    deployer.then(async() => {
        await doDeploy(deployer);
    });
}