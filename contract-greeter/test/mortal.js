const Mortal = artifacts.require("Mortal");

contract('Mortal', function(accounts) {

  let instance;

  beforeEach('setup contract for each following test', async function () {
    instance = await Mortal.new();
  });

  it("checks that the first account is the contract creator", async function () {
    const owner = await instance.owner();
    assert.equal(owner, accounts[0], "the owner is not the first account of the blockchain");
  });

  it("should be killed correctly", async function () {
    const bytecode_before = web3.eth.getCode(instance.address);
    await instance.kill.sendTransaction({"from": accounts[0]});

    const bytecode = web3.eth.getCode(instance.address);
    assert.notEqual(bytecode_before, bytecode, "the contract was not killed");
    assert.equal(bytecode, "0x0", "the contract was not killed correctly");
  });
});
