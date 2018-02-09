# Notes

## More information

See more at [OpenZeppelin docs](https://github.com/OpenZeppelin/zeppelin-solidity)

## TODO

Testing

## Commands executed via 'truffle console' via web3.js API

```bash
> truffle console

// The account that will buy GUS tokens.

> account1 = web3.eth.accounts[1]
'0xddac5d057c79facd674bc95dfd9104076fd34d6b'

// The address of the GUS token instance that was created when the crowdsale contract was deployed
// assign the result of GustavoCoinCrowdsale.deployed() to the variable crowdsale
> GustavoCoinCrowdsale.deployed().then(inst => { crowdsale = inst })
> undefined

> crowdsale.token().then(addr => { tokenAddress = addr } )
> tokenAddress
'0x87a784686ef69304ac0cb1fcb845e03c82f4ce16'

> gustavoCoinInstance = GustavoCoin.at(tokenAddress)

Now check the number of GUS tokens account1 has. It should have 0

gustavoCoinInstance.balanceOf(account1).then(balance => balance.toString(10))
'0'

// Buying GUS tokens

> GustavoCoinCrowdsale.deployed().then(inst => inst.sendTransaction({ from: account1, value: web3.toWei(5, "ether")}))
{ tx: '0x68aa48e1f0d0248835378caa1e5b2051be35a5ff1ded82878683e6072c0a0cfc',
  receipt:
   { transactionHash: '0x68aa48e1f0d0248835378caa1e5b2051be35a5ff1ded82878683e6072c0a0cfc',
     transactionIndex: 0,
     blockHash: '0xb48ceed99cf6ddd4f081a99474113c4c16ecf61f76625a6559f1686698ee7d57',
     blockNumber: 5,
     gasUsed: 68738,
     cumulativeGasUsed: 68738,
     contractAddress: null,
     logs: [] },
  logs: [] }
undefined

// Check the amount of GUS tokens for account1 again. It should have some now.

> gustavoCoinInstance.balanceOf(account1).then(balance => account1GusTokenBalance = balance.toString(10))
'5000000000000000000000'

// When we created our token we made it with 18 decimals, which the same as what ether has. That's a lot of zeros, let's display without the decimals:

> web3.fromWei(account1GusTokenBalance, "ether")
'5000'
```