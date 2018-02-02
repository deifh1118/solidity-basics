pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Storage.sol";

contract TestStorage {

    function testInitialValueUsingDeployedContract() public {
        Storage storageContract = Storage(DeployedAddresses.Storage());
        uint storeDataExpected = 0;

        Assert.equal(storageContract.get(), storeDataExpected, "The data stored should be 0");
    }

    function testInitialValueUsingNewStorage() public {
        Storage storageContract = new Storage();
        uint storeDateExpected = 0;

        Assert.equal(storageContract.get(), storeDateExpected, "The data stored should be 0");
    }

    function testSetValue() public {
        Storage storageContract = new Storage();
        uint setValue = 10;
        uint expectedSetValue = setValue;
        uint actualSetValue;

        // Call to set contract function
        storageContract.set(setValue);

        // Getting the value when set has been executed
        actualSetValue = storageContract.get();

        Assert.equal(actualSetValue, expectedSetValue, appendUintToString("The value set must be ", setValue));
    }

    // Private functions
    function appendUintToString(string inStr, uint v) private pure returns (string str) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(48 + remainder);
        }
        bytes memory inStrb = bytes(inStr);
        bytes memory s = new bytes(inStrb.length + i);
        uint j;
        for (j = 0; j < inStrb.length; j++) {
            s[j] = inStrb[j];
        }
        for (j = 0; j < i; j++) {
            s[j + inStrb.length] = reversed[i - 1 - j];
        }
        str = string(s);
    }

    // @NotUsed
    function uintToString(uint v) private pure returns (string str) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(48 + remainder);
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        str = string(s);
    }

}
