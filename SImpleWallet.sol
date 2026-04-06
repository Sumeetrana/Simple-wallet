// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

contract SimpleWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You don't have access");
        _;
    }
}