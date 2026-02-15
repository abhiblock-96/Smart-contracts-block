# 🚀 Escrow Crowdfunding Smart Contract

A secure, transparent, and decentralized crowdfunding protocol built on Ethereum. This contract allows creators to set a funding goal and deadline, ensuring that funds are only released if the project is successful, otherwise providing automated refunds to contributors.

## 📌 Features

* **Trustless Escrow:** Funds are held by the contract, not the owner, until the goal is met.
* **Automated Refunds:** If the project fails to meet its goal by the deadline, contributors can "pull" their funds back.
* **Security First:** Implements the **Checks-Effects-Interactions** pattern to prevent reentrancy attacks.
* **Real-time Tracking:** Emits events for every contribution and for successful goal completion.

---

## 🛠 Technical Logic

### The Lifecycle

1. **Deployment:** Owner sets `goalAmount` (in wei) and `duration` (in seconds).
2. **Funding:** Users call `fund()` and send ETH. Their contribution is mapped to their address.
3. **Outcome A (Success):** Goal is reached before the deadline. Owner calls `withdraw()` to claim the total balance.
4. **Outcome B (Failure):** Deadline passes without hitting the goal. Users call `getRefund()` to reclaim their ETH.

### Key Security Measures

* **Pull over Push:** Refunds are not sent automatically; users must claim them. This prevents "Gas Griefing" attacks where a malicious contract blocks the refund loop.
* **State Management:** User balances are zeroed out *before* the transfer call to prevent reentrancy.

---

## 📖 API Reference

### State Variables

| Variable | Type | Description |
| --- | --- | --- |
| `goalAmount` | `uint` | The target funding amount in Wei. |
| `endTime` | `uint` | The Unix timestamp when the campaign ends. |
| `raisedAmount` | `uint` | Total funds collected so far. |

### Core Functions

* **`fund()`**: `external payable`. Allows users to send ETH.
* **`getRefund()`**: `external`. Allows donors to withdraw their ETH if the goal fails.
* **`withdraw()`**: `external onlyOwner`. Allows the creator to claim funds if the goal is met.
* **`checkContribution()`**: `external view`. Returns the caller's contribution amount.

---

## 🚀 Getting Started

### Prerequisites

* [Node.js](https://nodejs.org/)
* [Hardhat](https://hardhat.org/) or [Foundry](https://book.getfoundry.sh/)
* Metamask (for testnet deployment)

### Installation

1. Clone the repository.
2. Install dependencies (if using Hardhat):
`npm install`
3. Compile the contract:
`npx hardhat compile`

---

## 📜 License

This project is licensed under the **MIT License**.
