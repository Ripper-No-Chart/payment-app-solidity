// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "./Types.sol";
import "./PaymentModule.sol";

abstract contract ClientModule is PaymentModule {
    ClientType[] clients;
    uint nextClientId;

    function createClient(string memory _name, uint _amount) public returns (bool) {
        uint walletId = assignWallet(nextClientId, _amount);
        clients.push(ClientType(nextClientId, _name, walletId));
        nextClientId++;
        return true;
    }

    function getClients() public view returns (ClientType[] memory) {
        return (clients);
    }

    function searchClientIndex(uint _id) internal view returns (bool, uint) {
        for (uint i = 0; i < clients.length; i++) {
            if (clients[i].id == _id) {
                return (true, i);
            }
        }
        return (false, 0);
    }

    function getClientById(
        uint _id
    ) public view returns (uint _clientId, string memory _clientName) {
        (bool clientFound, uint index) = searchClientIndex(_id);

        if (!clientFound) {
            revert("Client not found");
        }
        ClientType memory client = clients[index];

        return (client.id, client.name);
    }
}
