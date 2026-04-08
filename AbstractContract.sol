// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

abstract contract Parent {
    string public str;
    address public manager;

    constructor() {
        str = "Hello world";
        manager = msg.sender;
    }

    function setter(string memory _str) public virtual;
    function getter(string memory _str) public virtual;

    function randomFunction() public virtual returns(uint) {
        return 5;
    }
}

contract Child is Parent {
    function setter(string memory _str) public override {

    }
    
    function getter(string memory _str) public override {

    }
}