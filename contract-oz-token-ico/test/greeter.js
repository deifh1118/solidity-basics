const Greeter = artifacts.require("Greeter");

contract('Greeter', (accounts) => {

  let instance;
  const secondsPerDay = 86400;
  const daysInTheFuture = 3;

  const timeTravel = function (time) {
    return new Promise((resolve, reject) => {
      web3.currentProvider.sendAsync({
        jsonrpc: "2.0",
        method: "evm_increaseTime",           // increases the evm time for testrpc
        params: [time],                       // 86400 seconds per day
        id: (new Date).getTime()
      }, (err, result) => {
        if (err) {
          return reject(err);
        } else {
          return resolve(result);
        }
      });
    })
  };

  beforeEach('setup contract for each following test', async () => {
    instance = await Greeter.new("Hello world!");
  });

  it("checks that the first account is the contract creator", async () => {
    const owner = await instance.owner();

    assert.equal(owner, accounts[0], "the owner is not the first account of the blockchain");
  });

  it("should greet correctly", async () => {
    const greeting = await instance.greet();

    assert.equal(greeting, "Hello world!", "the contract does not greet 'Hello World!' correctly");
  });

  it("should call fnWithModifier without errors", async () => {
    let statusExpected, statusFnWithModifier;

    await timeTravel(secondsPerDay * daysInTheFuture);
    // await mineBlock();   // not necessary, but is a workaround for https://github.com/ethereumjs/testrpc/issues/336
    statusExpected = true;
    statusFnWithModifier = await instance.fnWithModifier();

    assert.equal(statusFnWithModifier, statusExpected, "The status of the 'fnWithModifier' function should be true");
  });

});
