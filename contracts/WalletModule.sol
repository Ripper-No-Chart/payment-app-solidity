// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "./Types.sol";

abstract contract WalletModule {
    WalletType[] internal wallets;
    uint internal nextWalletId;

    event BalanceToppedUp(address walletAddress, uint amount, uint newBalance);

    function assignWallet(
        uint _clientId,
        uint _amount
    ) internal returns (uint) {
        require(!walletExists(msg.sender), "Wallet already registered");
        wallets.push(WalletType(nextWalletId, msg.sender, _clientId, _amount));
        uint walletId = nextWalletId;
        nextWalletId++;
        return walletId;
    }

    function walletExists(address _walletAddress) internal view returns (bool) {
        for (uint i = 0; i < wallets.length; i++) {
            if (wallets[i].walletAddress == _walletAddress) {
                return true;
            }
        }

        return false;
    }

    function searchWalletIndex() internal view returns (bool, uint) {
        for (uint i = 0; i < wallets.length; i++) {
            if (wallets[i].walletAddress == msg.sender) {
                return (true, i);
            }
        }

        return (false, 0);
    }

    function getWallets() public view returns (WalletType[] memory) {
        return wallets;
    }

    function getWalletByClientId(
        uint _clientId
    ) public view returns (WalletType memory) {
        for (uint i = 0; i < wallets.length; i++) {
            if (wallets[i].clientId == _clientId) {
                return wallets[i];
            }
        }

        revert("Wallet not found");
    }

    function topUp(uint _amount) public returns (bool) {
        require(_amount > 0, "Amount must be greater than 0");
        (bool found, uint index) = searchWalletIndex();
        require(found, "Wallet not found");
        WalletType storage wallet = wallets[index];
        wallet.amount += _amount;
        emit BalanceToppedUp(msg.sender, _amount, wallet.amount);
        return true;
    }
}
