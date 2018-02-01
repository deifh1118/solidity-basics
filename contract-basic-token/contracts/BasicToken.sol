pragma solidity ^0.4.18;

contract BasicToken {

    /* Contract variables */
    address public owner;
    mapping (address => uint256) public balances;

    /* Contract constructor */
    function BasicToken(uint256 initialSupply) public {
        owner = msg.sender;                                 // Set the creator as the owner
        balances[owner] = initialSupply;                    // Give the creator all initial tokens
    }

    /* Function to send coins to an address*/
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);            // Check if the sender has enough
        require(balances[_to] + _value >= balances[_to]);   // Check for overflows
        balances[msg.sender] -= _value;                     // Subtract from the sender
        balances[_to] += _value;                            // Add the same to the recipient

        return true;
    }

    /* Function to send coins from an address to another */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balances[_from] >= _value);                 // Check if the sender has enough
        require(balances[_to] + _value >= balances[_to]);   // Check for overflows
        balances[_from] -= _value;                          // Subtract from the sender
        balances[_to] += _value;                            // Add the same to the recipient

        return true;
    }

}
