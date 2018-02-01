/*
 * Non-ES6 test
 */
// var Greeter = artifacts.require("Greeter");
//
// contract('Greeter', function(accounts) {
//
//   it("checks that the first account is the contract creator", function () {
//     var greeterInstance = Greeter.deployed();
//
//     greeterInstance.then(function (instance) {
//       var owner = instance.owner.call();
//       assert.equal(owner, accounts[0], "the owner is not the first account of the blockchain");
//     });
//   });
//
//   var greeterInstanceBeforeEach;
//
//   beforeEach('setup contract for each following test', function () {
//     greeterInstanceBeforeEach = Greeter.new("Hello world!");
//   });
//
//   it("should greet correctly", function () {
//     greeterInstanceBeforeEach.then(function (instance) {
//       var greeting = instance.greet.call().then(function (greetingResult) {
//         assert.equal(greetingResult, "Hello world!", "the contract does not greet 'Hello World!' correctly");
//       });
//     });
//   });
// });
