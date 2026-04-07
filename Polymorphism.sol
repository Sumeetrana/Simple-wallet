// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

contract Polymorphism {
    function add(uint a, uint b) external pure returns (uint) {
        return a + b;
    }

    function add(uint a, uint b, uint c) external pure returns (uint) {
        return a + b + c;
    }
}
