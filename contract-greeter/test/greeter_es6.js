const Greeter = artifacts.require("Greeter");

contract('Greeter', function(accounts) {

  let instance;

  beforeEach('setup contract for each following test', async function () {
    instance = await Greeter.new("Hello world!");
  });

  it("checks that the first account is the contract creator", async function () {
    const owner = await instance.owner();
    assert.equal(owner, accounts[0], "the owner is not the first account of the blockchain");
  });

  it("should greet correctly", async function () {
    const greeting = await instance.greet();
    assert.equal(greeting, "Hello world!", "the contract does not greet 'Hello World!' correctly");
  });
});
