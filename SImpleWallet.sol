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

    function transferToContract() external payable {}

    function getContractBalanceInWei() external view returns (uint) {
        return address(this).balance;
    }

    function transferToUserViaContract(
        address payable _to,
        uint _weiAmount
    ) external {
        require(address(this).balance >= _weiAmount, "Insufficient balance");

        (bool success, ) = _to.call{value: _weiAmount}("");
        require(success, "Transfer failed");
    }
}
