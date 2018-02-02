pragma solidity ^0.4.18;

contract Storage {

    uint256 storedData;

    function Storage() public {
        storedData = 0;
    }

    function set(uint256 data) public {
        storedData = data;
    }

    function get() public view returns (uint256) {
       return storedData;
    }

}
