var Greeter = artifacts.require("./DHCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(Greeter, "Hello world!");
};