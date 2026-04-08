// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

contract Car {
    uint public wheels = 4;
    uint public doors = 4;
    string public brandName = "CTE";
    uint public headlights = 2;
    bool public safetyBag = true;
}

contract SportsCar is Car {
    uint speed = 500;
    
}