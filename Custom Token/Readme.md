MyToken - A Simple ERC-20-like Token
This project contains a basic implementation of a cryptocurrency token on the Ethereum blockchain using Solidity. The MyToken contract includes core functionalities like minting new tokens, transferring tokens between accounts, and checking balances.
## 📜 Description
This smart contract creates a custom token with a name ("FLEETCOIN") and a symbol ("FLT"). The contract deployer is set as the owner and is the only one with the authority to mint new tokens. The initial supply is minted to the owner's address upon deployment.
## ✨ Features
 * Token Metadata: The token has a name and a symbol.
 * Total Supply: Tracks the total number of tokens in circulation.
 * Balance Tracking: Uses a mapping to store the token balance for each address.
 * Minting: The owner can create (mint) new tokens and assign them to any address.
 * Transfers: Users can transfer their tokens to other addresses.
 * Ownership: The contract has an owner with special privileges (minting).
## 🛠️ Getting Started
You can deploy and interact with this contract using any Ethereum development environment like Remix, Hardhat, or Foundry.
### Prerequisites
 * An Ethereum wallet (e.g., MetaMask).
 * An environment like Remix IDE.
### Deployment
 * Compile the Contract: Open the MyToken.sol file in Remix and compile it using a 0.8.30 or compatible Solidity compiler.
 * Deploy:
   * Navigate to the "Deploy & Run Transactions" tab in Remix.
   * In the DEPLOY section, enter the initialSupply for your token. For example, to create 1,000 tokens with 18 decimal places, you would enter 1000000000000000000000.
   * Click the "Deploy" button and confirm the transaction in your wallet.
### Interacting with the Contract
Once deployed, you can use the functions available in Remix to interact with your contract:
 * balanceOf(address): Enter an Ethereum address to check its token balance.
 * transfer(address, amount): Enter a recipient's address and the amount of tokens to send. You must be connected with an account that holds enough tokens.
 * mint(recipient, amount, _name, _symbol): Only the owner can call this. Enter a recipient's address and the amount to create new tokens. The name and symbol will also be updated.
 * totalSupply, name, symbol: These are public variables you can query directly to get their current values.
## ⚙️ Contract Functions
### State Variables
 * name: string - The name of the token (e.g., "FLEETCOIN").
 * symbol: string - The symbol of the token (e.g., "FLT").
 * totalSupply: uint256 - The total amount of tokens in existence.
 * balances: mapping(address => uint256) - Stores the token balance of each address.
 * owner: address - The address of the contract creator, who has minting rights.
### Public Functions
 * constructor(uint256 initialSupply)
   * Initializes the contract, setting the msg.sender as the owner.
   * Mints the initialSupply of tokens to the owner's address.
 * mint(address recipient, uint256 amount, string memory _name, string memory _symbol)
   * Creates amount new tokens and adds them to the recipient's balance.
   * Increases the totalSupply by amount.
   * Note: This function can only be called by the owner.
 * balanceOf(address account) public view returns (uint256)
   * Returns the token balance of the specified account.
 * transfer(address recipient, uint256 amount) public returns (bool)
   * Transfers amount tokens from the msg.sender's balance to the recipient's balance.
   * Requires the sender to have a sufficient balance.
## 📄 License
This project is licensed under the MIT License. See the LICENSE file for details.