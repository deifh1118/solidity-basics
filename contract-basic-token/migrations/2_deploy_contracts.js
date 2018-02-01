var BasicToken = artifacts.require("./BasicToken.sol");

module.exports = function(deployer) {
  deployer.deploy(BasicToken, 2000);        // 2000 tokens for the initial supply
};