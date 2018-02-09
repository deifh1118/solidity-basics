pragma solidity ^0.4.18;

import "./DHCoin.sol";
import "zeppelin-solidity/contracts/crowdsale/Crowdsale.sol";

contract DHCoinCrowdsale is Crowdsale {

    /* Contract constructor */
    function DHCoinCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet)
        Crowdsale(_startTime, _endTime, _rate, _wallet) public {

    }

    /* Token creation to be sold */
    /* The following method is overwritten from the Crowdsale contract to have a crowdsale of a MintableToken token */
    function createTokenContract() internal returns (MintableToken) {
        return new DHCoin();
    }

}
