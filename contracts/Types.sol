// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

struct WalletType {
    uint id;
    address walletAddress;
    uint clientId;
    uint amount;
}

struct CommerceType {
    uint id;
    string name;
}

struct ClientType {
    uint id;
    string name;
    uint walletId;
}

struct PaymentType {
    uint id;
    address walletAddress;
    uint amount;
}
