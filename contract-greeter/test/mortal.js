const Mortal = artifacts.require("Mortal");

contract('Mortal', (accounts) => {

  let instance;

  beforeEach('setup contract for each following test', async () => {
    instance = await Mortal.new();
  });

  it("checks that the first account is the contract creator", async () => {
    const owner = await instance.owner();

    assert.equal(owner, accounts[0], "the owner is not the first account of the blockchain");
  });

  it("should be killed correctly", async () => {
    const bytecode_before = web3.eth.getCode(instance.address);
    let bytecodeAfter;

    await instance.kill.sendTransaction({"from": accounts[0]});
    bytecodeAfter = web3.eth.getCode(instance.address);

    assert.notEqual(bytecode_before, bytecodeAfter, "the contract was not killed");
    assert.equal(bytecodeAfter, "0x0", "the contract was not killed correctly");
  });
});
