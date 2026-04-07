// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our version

contract SimpleWallet {
    struct Transaction {
        address from;
        address to;
        uint timestamp;
        uint amount;
    }

    Transaction[] public transactionHistory;

    address public owner;
    event Transfer(address receiver, uint amount);
    event Recieve(address sender, address reciever, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You don't have access");
        _;
    }

    // Transfer user balance to contract
    function transferToContract() external payable {
        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: address(this),
                timestamp: block.timestamp,
                amount: msg.value
            })
        );
    }

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

        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: _to,
                timestamp: block.timestamp,
                amount: _weiAmount
            })
        );
    }

    function withdrawFromContract(uint _weiAmount) external onlyOwner {
        (bool success, ) = owner.call{value: _weiAmount}("");
        require(success, "Transfer to owner failed");

        transactionHistory.push(
            Transaction({
                from: address(this),
                to: owner,
                timestamp: block.timestamp,
                amount: _weiAmount
            })
        );
    }

    // Transfering directly from thr user's account to another user's account
    function transferToUserViaMsgValue(address _to) external payable {
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "Transaction failed");

        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: _to,
                timestamp: block.timestamp,
                amount: msg.value
            })
        );
    }

    // Receive money from user to owner
    function receiveFromUser() external payable {
        require(msg.value >= 0, "Wei value must be greater than 0");

        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Transaction failed");

        emit Recieve(msg.sender, owner, msg.value);

        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: owner,
                timestamp: block.timestamp,
                amount: msg.value
            })
        );
    }

    function getOwnerBalanceInWei() external view returns (uint) {
        return owner.balance;
    }

    function getTransactionHistory()
        external
        view
        returns (Transaction[] memory)
    {
        return transactionHistory;
    }

    receive() external payable {
        transactionHistory.push(
            Transaction({
                from: msg.sender,
                to: address(this),
                timestamp: block.timestamp,
                amount: msg.value
            })
        );
    }

    fallback() external payable {}
}
