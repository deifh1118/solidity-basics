var Counter = artifacts.require("./BasicToken.sol");

module.exports = function(deployer) {
  deployer.deploy(Counter);
};