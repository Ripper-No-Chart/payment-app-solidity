# PaymentApp

A modular Solidity smart contract project that simulates a simple payment system with clients, wallets, balances, top-ups, and payments.

The project was built as a learning exercise focused on Solidity fundamentals, contract architecture, state management, transaction validation, inheritance, and event handling.

## Features

- Client registration
- Automatic wallet association using `msg.sender`
- Wallet balance management
- Wallet top-ups
- Payments between the user and the application balance system
- Payment history
- Duplicate wallet prevention
- Balance validation
- Solidity events for important operations
- Modular contract architecture
- Single final deployable contract

## Architecture

The project uses Solidity inheritance to separate responsibilities between modules.

```text
WalletModule
    ↑
PaymentModule
    ↑
ClientModule
    ↑
PaymentApp
```

Only `PaymentApp` is intended to be deployed.

The other contracts act as internal modules that provide functionality to the final contract.

## Project Structure

```text
contracts/
├── Types.sol
├── WalletModule.sol
├── PaymentModule.sol
├── ClientModule.sol
└── PaymentApp.sol
```

### `Types.sol`

Contains the shared data structures used across the project.

Main structures include:

- `WalletType`
- `ClientType`
- `PaymentType`

### `WalletModule.sol`

Responsible for wallet-related logic.

Includes functionality for:

- Wallet creation
- Wallet lookup
- Wallet validation
- Balance queries
- Balance top-ups
- Duplicate wallet prevention
- Wallet-related events

### `PaymentModule.sol`

Responsible for payment logic.

Includes:

- Payment execution
- Balance validation
- Payment history
- Payment events

Payments are always associated with `msg.sender`, preventing a user from manually selecting another wallet.

### `ClientModule.sol`

Responsible for client management.

Includes:

- Client creation
- Client lookup
- Client queries
- Wallet association

Each client is associated with the wallet created from the caller's `msg.sender`.

### `PaymentApp.sol`

Final deployable contract.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "./ClientModule.sol";

contract PaymentApp is ClientModule {
}
```

The final contract inherits all wallet, payment, and client functionality through the module inheritance chain.

## Example Flow

```text
User
  ↓
createClient()
  ↓
msg.sender becomes the associated wallet
  ↓
Wallet is created
  ↓
Client is created
  ↓
topUp()
  ↓
Balance increases
  ↓
pay()
  ↓
Balance decreases
  ↓
Payment is recorded
```

## Validation

The contracts use `require` statements to prevent invalid operations.

Examples include:

- Registering the same wallet more than once
- Using an unregistered wallet
- Sending an amount equal to zero
- Making a payment with insufficient balance

If a validation fails, the transaction is reverted and no state changes are persisted.

## Events

The project emits events for important state changes.

Examples:

```solidity
event BalanceToppedUp(
    address walletAddress,
    uint amount,
    uint newBalance
);
```

```solidity
event PaymentDone(
    address walletAddress,
    uint amount
);
```

These events can later be consumed by frontend applications or blockchain indexing tools.

## Technology

- Solidity `^0.8.34`
- Remix IDE
- Ethereum-compatible networks

Planned integration:

- Sepolia Testnet
- MetaMask
- ethers.js
- Angular

## Running with Remix

1. Open the project in Remix IDE.
2. Compile `PaymentApp.sol`.
3. Select `PaymentApp` as the contract to deploy.
4. Deploy using the Remix VM.
5. Create a client.
6. Test wallet queries.
7. Test `topUp()`.
8. Test `pay()`.
9. Verify balances.
10. Verify payment history and emitted events.

## Current Status

The core Solidity implementation is functional and has been tested using the Remix VM.

Completed:

- Modular architecture
- Client creation
- Wallet creation
- Wallet ownership based on `msg.sender`
- Duplicate wallet validation
- Balance management
- Top-up functionality
- Payment functionality
- Payment history
- Events
- Error handling

Next steps:

- Deploy to Sepolia Testnet
- Verify contract behavior on a public test network
- Export ABI
- Store deployed contract address
- Connect MetaMask
- Integrate with Angular using ethers.js
- Add automated Solidity tests
- Review the project for additional smart contract security improvements

## Important Note

The current balance system is a simulation.

The `amount` stored inside each wallet is an internal Solidity value and does not represent real ETH, ERC-20 tokens, or fiat currency.

The current `topUp()` functionality increases the internal simulated balance and does not transfer native ETH.

Future versions may introduce real asset handling using native ETH or token standards.

## Learning Goals

This project was created to practice:

- Solidity syntax
- Smart contract state
- Structs
- Arrays
- `msg.sender`
- `require` and transaction reverts
- `memory` and `storage`
- Internal and public functions
- Contract inheritance
- Modular smart contract design
- Events and `emit`
- State-changing transactions
- Basic smart contract security principles

## License

This project is licensed under the MIT License.
