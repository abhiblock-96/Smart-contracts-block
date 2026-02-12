# ERC20 Token Smart Contract

A custom, from-scratch implementation of the **ERC20 Standard** written in Solidity. This contract manages a fungible token with minting, burning, and delegated spending capabilities.

## 🚀 Features

* **Standard Compliance**: Follows the ERC20 interface for compatibility with wallets (MetaMask) and DEXs (Uniswap).
* **Decimals Support**: Configurable decimal places (defaulting to 18) to allow fractional token transfers.
* **Minting**: Allows the contract owner to create new tokens and increase the total supply.
* **Burning**: Allows any token holder to permanently destroy their tokens, reducing the total supply.
* **Delegated Transfers**: Full implementation of `approve` and `transferFrom` for secure third-party spending.

---

## 📊 Tokenomics Logic

| Function | Access | Description |
| --- | --- | --- |
| `mint` | **Owner Only** | Increases `totalToken` and adds balance to the owner. |
| `burn` | **Public** | Decreases `totalToken` and removes balance from the caller. |
| `transfer` | **Public** | Peer-to-peer token movement. |
| `approve` | **Public** | Sets an allowance for a spender. |

---

## 🛠 Technical Details

### Unit Management

The contract handles all math in **Base Units** (Integers).

* **Internal Storage**: If `decimals` is set to 18, 1 full token is stored as  units.
* **External Input**: Functions like `transfer` and `burn` expect the amount in these base units.

### Security Checks

* **Requirement Checks**: Validates balances and allowances before every state change.
* **Zero-Address Guard**: Prevents accidental token loss by blocking transfers to `address(0)`.
* **Integer Safety**: Built with Solidity ^0.8.30, utilizing native overflow/underflow protection.

---

## 💻 How to Use

### Deployment

1. Open [Remix IDE](https://www.google.com/search?q=https://remix.ethereum.org/).
2. Create a new file named `ERC20.sol` and paste the code.
3. Compile using version **0.8.30** or higher.
4. Deploy by providing:
* `_name`: Your Token Name
* `_symbol`: Your Symbol
* `_totalSupply`: Initial supply (Human readable, e.g., 1000)
* `_decimal`: Decimal count (Standard is 18)



### Testing the "Allowance" Flow

1. **Account A** calls `approve(Account B, 500)`.
2. **Account B** calls `transferFrom(Account A, Account C, 500)`.
3. The contract verifies the allowance, deducts it, and moves the tokens from A to C.

---

## 📄 License

This project is licensed under the **MIT License**.

---
