pragma solidity ^0.4.20;

contract Counter {

    /* Contract variables */
    int private count;

    /* Contract constructor */
    function counter() {
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