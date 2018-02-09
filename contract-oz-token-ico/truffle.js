// Allows us to use ES6 in our migrations and tests.
require('babel-register');

/* The polyfill will emulate a full ES6 environment. This polyfill is automatically loaded when using babel-node.
 * Usage in Node / Browserify / Webpack:
 * To include the polyfill you need to require it at the top of the entry point to your application
 * (in this case truffle.js).
 */
require('babel-polyfill');

module.exports = {
    // See <http://truffleframework.com/docs/advanced/configuration>
    // to customize your Truffle configuration!
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*" // Match any network id
        }
    }
};
