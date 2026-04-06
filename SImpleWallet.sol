// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

contract SimpleWallet {
    address public owner;
    event Transfer(address receiver, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You don't have access");
        _;
    }

    // Transfer user balance to contract
    function transferToContract() external payable {}

    function getContractBalanceInWei() external view returns (uint) {
        return address(this).balance; // Get the balance of the contract
    }

    function transferToUserViaContract(
        address payable _to,
        uint _weiAmount
    ) external {
        require(address(this).balance >= _weiAmount, "Insufficient balance");

        (bool success, ) = _to.call{value: _weiAmount}("");
        require(success, "Transfer failed");

        emit Transfer(_to, _weiAmount);
    }

    function withdrawFromContract(uint _weiAmount) external onlyOwner {
        (bool success, ) = owner.call{value: _weiAmount}("");
        require(success, "Transfer to owner failed");
    }

    // Transfering directly from thr user's account to another user's account
    function transferToUserViaMsgValue(address _to) external payable {
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "Transaction failed");
    }

    // Receive money from user to owner
    function receiveFromUser() external payable {
        require(msg.value >= 0, "Wei value must be greater than 0");

        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Transaction failed");
    }

    function getOwnerBalanceInWei() external view returns (uint) {
        return owner.balance;
    }

    receive() external payable {}

    fallback() external payable {}
}
