# Smart Warehouse Manager

A Solidity smart contract designed to handle inventory management on the Ethereum blockchain. This project demonstrates foundational concepts of smart contract development, including data structures, access control, and gas-efficient loops.

## Features
* **Access Control:** Only the contract owner can add or update products.
* **Dynamic Inventory:** Uses Structs and Arrays to store product details (Name, Price, ID, Status).
* **Automated ID:** Generates unique product IDs using `block.timestamp`.
* **State Management:** Tracks product lifecycle through Enums (`OutOfStock`, `Available`, `Discontinued`).
* **Inventory Reports:** A view function to calculate the total number of available items using a for-loop.

## Technical Stack
* **Language:** Solidity ^0.8.0
* **Environment:** Remix IDE
* **Concepts Used:** * Custom Modifiers (`onlyOwner`)
    * Structs & Enums
    * State Variables & Visibility
    * Events (logging product additions)

## How to Use
1. **Deploy:** Deploy the contract to a JavaScript VM or Testnet using Remix IDE.
2. **Add Products:** Use `addProducts` with a name, price, and status (0, 1, or 2).
3. **Update:** Change product availability using `updateStatus` and the item's index.
4. **Query:** Call `countProduct` to see how many items are currently available for sale.

## Learning Outcomes
This project was built to practice:
- Data organization via **Structs**.
- Optimizing logic with **Loops** and **Conditionals**.
- Implementing security patterns with **Modifiers**.