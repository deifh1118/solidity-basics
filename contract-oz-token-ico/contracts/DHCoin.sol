pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";

contract DHCoin is MintableToken {

    /* Contract variables */
    string public name = "DH COIN";
    string public symbol = "DHC";
    uint8 public decimals = 18;

}
