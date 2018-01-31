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

For compiling a smart contract we use the following command:

```bash
> truffle compile
```

This will generate a new build folder (if it does not exist already)
with the compiled contract in a json format.

For deploying a smart contract we use the following command:

```bash
> truffle migrate [--reset]
```

This command uploads the contract to a blockchain, so it could be interacted with
using the ``` truffle console ``` command.
The reset flag allows us to force to redeploy to a contract into a blockchain.

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

- Eliminar un contrato y liberar recursos:

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

- Obtener el owner de un contrato

```bash
truffle(development)> i.owner.call()
'0xe10c0b784b1a051f24bb93e36c1f4c851d4210b3'
truffle(development)> i.contract.owner.call()
'0xe10c0b784b1a051f24bb93e36c1f4c851d4210b3'
```

## License

MIT license.