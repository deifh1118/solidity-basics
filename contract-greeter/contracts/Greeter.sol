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

    /* Contract constructor */
    function Greeter(string _greeting) public {
        greeting = _greeting;
    }

    /* Main function of the contract */
    function greet() public constant returns (string) {
        return greeting;
    }

}