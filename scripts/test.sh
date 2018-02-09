#! /bin/bash

# -----------------------------------------------------------------------------------
# Inspired in zeppelin-solidity test script
# See 'https://github.com/OpenZeppelin/zeppelin-solidity/blob/v1.2.0/scripts/test.sh'
# -----------------------------------------------------------------------------------

# Fire up a ganache-cli instance and execute the tests. To clean up after the execution we kill the ganache-cli process
(ganache-cli > /dev/null & truffle test) && kill -9 $(lsof -ti :8545);

exit 0;