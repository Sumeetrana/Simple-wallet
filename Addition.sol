// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./Library.sol";

contract Sum {
    function addition(uint a, uint b) external pure returns (uint) {
        return Addition.add(a, b);
    }
}
