pragma solidity ^0.4.18;

contract Mortal {

    /* Contract variables */
    address public owner;

    /* This function is the constructor, executed at initialization
     * due to contract creation. It sets the owner of the contract
     */
    function Mortal() public {
        owner = msg.sender;
    }

    /* It recovers the funds of the contract */
    function kill() public {
        if (msg.sender == owner) {
            selfdestruct(owner);
        }
    }

}

contract Greeter is Mortal {

    /* Contract variables */
    string public greeting;
    uint public endTime;

    /* Contract constructor */
    function Greeter(string _greeting) public {
        greeting = _greeting;
        endTime = 1 days;
    }

    /* onlyAfterDate modifier that requires that the time is a number of days in the future from now */
    modifier onlyAfterDate() {
        if (now <= endTime) {
            revert();
        } else {
            _;
        }
    }

    /* Main function of the contract */
    function greet() public view returns (string) {
        return greeting;
    }

    /* Function to test the use of a modifier */
    function fnWithModifier() onlyAfterDate public view returns (bool success) {
        return true;
    }

}
