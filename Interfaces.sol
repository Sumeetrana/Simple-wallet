// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

interface IGreeter {
    function greet() external pure returns (string memory);
}

contract Greeter is IGreeter {
    function greet() external pure returns (string memory) {
        return "Hello world";
    }
}

contract SayHello {
    function getGreet(
        address _greeterContract
    ) external pure returns (string memory) {
        return IGreeter(_greeterContract).greet();
    }
}
