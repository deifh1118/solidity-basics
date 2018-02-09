# solidity-basics

## Zeppelin

OpenZeppelin is a library to write Smart Contracts in the Solidity language
following common contract security patterns.

### Installation

The OpenZeppelin library integrates with the Triffle framework.
To install OpenZeppelin library in a Truffle project we can do the following:

```bash
npm install -g truffle
mkdir myproject && cd myproject
truffle init

# Installation of the OpenZeppelin library ('-E' stands for '--save-exact'):
npm init -y
npm install -E zeppelin-solidity
```

Documentation at: [zeppelin-solidity](https://github.com/OpenZeppelin/zeppelin-solidity)

### Reusable out-of-the-box contracts

OpenZeppelin uses a set of Smart Contracts that follow common security patterns
and implement common functionality. These functionalities go from ownership
to tokens and crowdsales. The contracts that are offered by the library are presented
in this link belonging to the library's Github:

[OpenZeppelin (zeppelin-solidity) contracts](https://github.com/OpenZeppelin/zeppelin-solidity/tree/master/contracts)

## License

MIT license.
