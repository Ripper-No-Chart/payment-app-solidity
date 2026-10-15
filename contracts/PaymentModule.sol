// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "./Types.sol";
import "./WalletModule.sol";

abstract contract PaymentModule is WalletModule {
    PaymentType[] payments;
    uint nextPaymentId;

    event PaymentDone (address wallletAddress, uint Amount);

    function pay(uint _amount) public returns (bool) {
        (bool found, uint index) = searchWalletIndex();
        require(found, "Wallet not found");
        require(_amount > 0, "Amount must be greater than 0");

        WalletType storage wallet = wallets[index];

        require(wallet.amount >= _amount, "Insufficient balance");
        wallet.amount -= _amount;
        payments.push(PaymentType(nextPaymentId, msg.sender, _amount));
        nextPaymentId++;
        emit PaymentDone(msg.sender, _amount);
        return true;
    }

    function getPayments() public view returns (PaymentType[] memory) {
        return payments;
    }
}
