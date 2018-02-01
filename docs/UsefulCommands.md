# solidity-basics

## Useful commands

Useful commands used to compile, deploy and interact with smart contracts via Truffle.

### Environment instalation

To install the environment we have to install the following tools:

- Truffle is a framework used to compile, deploy and interact with smart contracts.
- The geth tool could be used too for this purpose.
- testrpc should also be installed to have a blockchain testnet
to host the smart contracts.

[TODO]

## Commands

### Startup of a test blockchain

We can start a test blockchain using the testrpc tool like so:

```bash
testrpc
```

This testnet has a number of accounts predefined to use to test smart contracts.

### Scaffolding, compiling and deploying a smart contract

To scaffold the structure of a smart contract we could use:

```bash
> truffle init
```

This command would scaffold the following structure:

- contracts: folder to store the contracts.
- migrations: nodejs scripts to deploy the smart contracts when
``` truffle migrate ``` is used.
- test: folder to store the contracts tests.
- truffle.js / truffle-config.js: truffle configuration
(i.e. network configuration for connecting with a blockchain like testrpc).

For creating a smart contract we can use the following command:

```bash
> truffle create contract Greeter
```

This command will create a contract in the contracts folder.

Note: The name of the contract must be CamelCased.

For compiling a smart contract we use the following command:

```bash
> truffle compile
```

This will generate a new build folder (if it does not exist already)
with the compiled contract in a json format.

In order to deploy the contract in an Ethereum blockchain we need to create
a migration under the migrations folder that accomplishes the task
of deploying the contract. This command is as follows:

```bash
> truffle create migration deploy_greeter
```

When the command is executed a file in the migrations folder will be
automatically created with the pattern:

``` migrations/<timestamp>_migrationname.js ```

For deploying a smart contract we use the following command:

```bash
> truffle migrate [--reset]
```

This command uploads the contract to a blockchain, so it could be interacted with
using the ``` truffle console ``` command.
The reset flag allows us to force to redeploy to a contract into a blockchain.

### Testing a smart contract

Truffle has built-in testing support. We can test a contract before deploying it
to a real blockchain.

To create a test for a contract the following command could be used:

```bash
> truffle create test Greeter
```

This command will create a test file in the tests folder.

Note: The name of the contract must be CamelCased.

A test example is described below:

```javascript
const HelloWorld = artifacts.require('HelloWorld')
  
contract('HelloWorld', function(accounts) {
    
  it('sets the first account as the contract creator', async function() {
    // This give a truffle abstraction which allow us to interact with our contracts.
    const contract = await HelloWorld.deployed()

    // Once we have the "contract" we can make calls or transations and then assert.
    // The following is making a call to get the creator.
    const creator = await contract.getCreator()

    assert.equal(creator, accounts[0], 'main account is the creator')
  })
  
  it('has hello world as initial message ', async function() {
    const contract = await HelloWorld.deployed()
    const message = await contract.getMessage()

    assert.equal(message, 'hello world', 'message is hello world')
  })
  
  it('changes the message via setMessage', async function() {
    const contract = await HelloWorld.deployed()

    // Execute a transaction and change the state of the contract.
    await contract.setMessage('hola mundo')

    // Get the new state.
    const message = await contract.getMessage()

    assert.equal(message, 'hola mundo', 'message is hola mundo')
  })
})
```

When the test is set up, the following command could be used to fire up the tests:

```bash
> truffle test
```


### Interacting with a smart contract

Interacting with a smart contract could be done with some frameworks
(geth, web3j, etc.), but one stands out as the de-facto framework for compiling,
deploying and interacting with smart contracts. To interact with a smart contract
via Truffle can be done like this:

```bash
> truffle console
```

Once this command is executed, a prompt will appear to input commands to interact
with a blockhain and smart contracts. Some commands that could be used
are the following (once a contract is deployed):

- Call a contract function that does not alter the contract state:

A call function is executed in this case (and not a transaction) because
the state of the contract is not altered in the blockchain.
To do so, a command like this could be executed:

```solidity
pragma solidity ^0.4.18;

contract Counter {

    /* Contract variables */
    int private count;

    /* Contract constructor */
    function Counter() public {
        count = 0;
    }

    /* This function increases the value of the counter by 1 */
    function incrementCounter() public {
        count += 1;
    }

    /* This function decreases the value of the counter by 1 */
    function decrementCounter() public {
        count -= 1;
    }

    /* This function returns the counter's value */
    function getCount() public view returns (int) {
        return count;
    }

}
```

```bash
truffle(development)> Counter.deployed().then(instance => instance.getCount.call()).then(result => counterData = result)
```

Note: ``` truffle(development) ``` refers to the blockchain that the truffle console
connects to. "development" is the name of the network specified
in the truffle js configuration for a smart contract. 

- Call a contract function that alters the contract state:

A transaction is executed against the blockchain because
the state of the contract is altered.
To do so, a command like this could be executed:

```bash
# Increment the counter
truffle(development)> Counter.deployed().then(instance => instance.incrementCounter.sendTransaction())

# Decrement the counter
truffle(development)> Counter.deployed().then(instance => instance.decrementCounter.sendTransaction())
```

- Delete a contract and release resources:

By default a contract has no owner but we can establish one, the one who
issues its creation. In order to eliminate a contract in this case,
the owner should be the one to do so, with these commands: 

```bash
# The contract address
truffle(development)> Greeter.address
'0x1542f55d3d0ac60ae8f544c1f3a8a57f7cd3c2ce'

# Get the bytecode of the contract
truffle(development)> web3.eth.getCode(Greeter.address)
'0x606060405260043610610062576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806341c0e1b5146100675780638da5cb5b1461007c578063cfae3217146100d1578063ef690cc01461015f575b600080fd5b341561007257600080fd5b61007a6101ed565b005b341561008757600080fd5b61008f61027e565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34156100dc57600080fd5b6100e46102a3565b6040518080602001828103825283818151815260200191508051906020019080838360005b83811015610124578082015181840152602081019050610109565b50505050905090810190601f1680156101515780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561016a57600080fd5b61017261034b565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156101b2578082015181840152602081019050610197565b50505050905090810190601f1680156101df5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16141561027c576000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16ff5b565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6102ab6103e9565b60018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156103415780601f1061031657610100808354040283529160200191610341565b820191906000526020600020905b81548152906001019060200180831161032457829003601f168201915b5050505050905090565b60018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156103e15780601f106103b6576101008083540402835291602001916103e1565b820191906000526020600020905b8154815290600101906020018083116103c457829003601f168201915b505050505081565b6020604051908101604052806000815250905600a165627a7a72305820d70e03f5e3d4dbc379fd09e153afd9fa2ee42a2c98776ad09575243041cac9b50029'

# Kill the contract
truffle(development)> Greeter.deployed().then(instance => instance.kill.sendTransaction())

# Checking again the contract address
truffle(development)> Greeter.address
'0x1542f55d3d0ac60ae8f544c1f3a8a57f7cd3c2ce'

# Getting the bytecode again
truffle(development)> web3.eth.getCode(Greeter.address)
'0x0'
```

- Get a contract's owner:

```bash
truffle(development)> i.owner.call()
'0xe10c0b784b1a051f24bb93e36c1f4c851d4210b3'
truffle(development)> i.contract.owner.call()
'0xe10c0b784b1a051f24bb93e36c1f4c851d4210b3'
```

- Get a contract's instance:

```bash
truffle(development)> Greeter.deployed().then(instance => i = instance)
...
```

- Obtain the balances of the accounts in a Token contract:

```bash
truffle(development)> BasicToken.deployed().then(instance => i = instance)
...
truffle(development)> web3.eth.accounts
[ '0x1b81267c9a7cdf18fc31e9428d6c08a3b9b9fc19',
  '0xe1d1702bd6508233c2338146f71d3180e42c1711',
  '0xe916cfb7c53e825a82b9b468673c602a162fe7bc',
  '0x0de543bd7da6a936c0a69014f093a64a1a497d0b',
  '0xfb60821dff9b32dbe82d2357916a16a80dd62143',
  '0xcfbc781e3bc38e3478b2ffcca44bfd70b1dfee94',
  '0x556f87e0eaa07367e61526f97d3b702da62569ce',
  '0x48c3dc5ceef1a2b3ef9c321bf5505d841ab7089e',
  '0xbf572b183f7369999c3936bba6b145820c6ce942',
  '0x9bded27966ef8da90a30beff797456bbdea72f92' ]
truffle(development)> i.balances.call(web3.eth.accounts[0])
BigNumber { s: 1, e: 3, c: [ 2000 ] }
truffle(development)> i.balances.call(web3.eth.accounts[0]).toString()
'[object Promise]'
truffle(development)> i.balances.call(web3.eth.accounts[0]).then(result => r = result)
BigNumber { s: 1, e: 3, c: [ 2000 ] }
truffle(development)> r.toString()
'2000'
truffle(development)> i.balances.call(web3.eth.accounts[1])
BigNumber { s: 1, e: 0, c: [ 0 ] }
```

- Transfer tokens between accounts:

```bash
truffle(development)> BasicToken.deployed().then(instance => i = instance)
...
truffle(development)> web3.eth.accounts
[ '0x1b81267c9a7cdf18fc31e9428d6c08a3b9b9fc19',
  '0xe1d1702bd6508233c2338146f71d3180e42c1711',
  '0xe916cfb7c53e825a82b9b468673c602a162fe7bc',
  '0x0de543bd7da6a936c0a69014f093a64a1a497d0b',
  '0xfb60821dff9b32dbe82d2357916a16a80dd62143',
  '0xcfbc781e3bc38e3478b2ffcca44bfd70b1dfee94',
  '0x556f87e0eaa07367e61526f97d3b702da62569ce',
  '0x48c3dc5ceef1a2b3ef9c321bf5505d841ab7089e',
  '0xbf572b183f7369999c3936bba6b145820c6ce942',
  '0x9bded27966ef8da90a30beff797456bbdea72f92' ]
truffle(development)> i.balances.call(web3.eth.accounts[0])
BigNumber { s: 1, e: 3, c: [ 2000 ] }
truffle(development)> i.balances.call(web3.eth.accounts[1])
BigNumber { s: 1, e: 0, c: [ 0 ] }
  
# Transfer to an address
truffle(development)> i.transfer.sendTransaction(web3.eth.accounts[1], 10, {from: web3.eth.accounts[0]})
'0xbc7ae7ad0434d39b6d43200c5c0c99f7a03e1d3a724a364e3ba8551230a4aa63'
truffle(development)> i.balances.call(web3.eth.accounts[0])
BigNumber { s: 1, e: 3, c: [ 1990 ] }
truffle(development)> i.balances.call(web3.eth.accounts[1])
BigNumber { s: 1, e: 1, c: [ 10 ] }
  
# Another transfer
truffle(development)> i.transfer.sendTransaction(web3.eth.accounts[2], 2, {from: web3.eth.accounts[1]})
'0x504b784af4f03958f38388b7384d2a78b78655320b1ca9920333b9197a29d83c'
truffle(development)> i.balances.call(web3.eth.accounts[0])
BigNumber { s: 1, e: 3, c: [ 1990 ] }
truffle(development)> i.balances.call(web3.eth.accounts[1])
BigNumber { s: 1, e: 0, c: [ 8 ] }
truffle(development)> i.balances.call(web3.eth.accounts[2])
BigNumber { s: 1, e: 0, c: [ 2 ] }
  
# Transfer to an address from another address
truffle(development)> i.transferFrom.sendTransaction(web3.eth.accounts[1], web3.eth.accounts[2], 2)
'0x4ddaef26bb08845ae7f56282ef4f0aaef2a55ca0c9b56ffabd13811f99e4893c'
truffle(development)> i.balances.call(web3.eth.accounts[0])
BigNumber { s: 1, e: 3, c: [ 1990 ] }
truffle(development)> i.balances.call(web3.eth.accounts[1])
BigNumber { s: 1, e: 0, c: [ 6 ] }
truffle(development)> i.balances.call(web3.eth.accounts[2])
BigNumber { s: 1, e: 0, c: [ 4 ] }
```

## License

MIT license.