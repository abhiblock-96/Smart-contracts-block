# 🗳️ VoteDapp - Decentralized Voting Smart Contract

A robust, transparent, and time-bound voting system built on Ethereum using **Solidity**. This contract allows an administrator to manage candidates and authorized voters while ensuring the integrity of the election process through blockchain technology.

## 🚀 Key Features

* **Time-Bound Voting:** Elections are initialized with a specific duration. Voting is only possible within this window.
* **Authorized Voting:** A "Chairperson" (contract owner) must authorize addresses before they can cast a vote.
* **Security:** Prevents double-voting and unauthorized candidate registration.
* **Real-time Leader Tracking:** The contract internally tracks the leading candidate to optimize result retrieval.
* **Winner Privacy:** Results are hidden until the election duration has officially ended.

---

## 🛠 Smart Contract Logic

The contract follows a specific lifecycle to ensure fairness:

1. **Deployment:** The owner deploys the contract and sets the election duration in seconds.
2. **Registration:** The owner adds candidates (Name & Party) and authorizes specific wallet addresses to vote.
3. **Voting Period:** Authorized users cast their votes for their preferred candidate index.
4. **Completion:** Once the `endVote` timestamp is passed, anyone can call the winner function to see the results.

---

## 📑 Function Overview

| Function | Access | Description |
| --- | --- | --- |
| `addCandidate` | **Owner Only** | Adds a new candidate to the election pool. |
| `chairPerson` | **Owner Only** | Authorizes a specific wallet address to vote. |
| `vote` | **Authorized User** | Casts a vote for a candidate (only during election hours). |
| `viewCandidate` | **Public** | Returns a list of all candidates and their details. |
| `checkWinner` | **Public** | Reveals the name of the winner after the election ends. |

---

## ⚙️ Technical Details

* **Solidity Version:** `^0.8.30`
* **License:** MIT
* **Events:**
* `Vote`: Emitted when a successful vote is cast.
* `AddCandidate`: Emitted when a new candidate is registered.



## 📦 Getting Started

1. **Compile:** Use Remix IDE or Hardhat to compile the contract.
2. **Deploy:** Provide the `_durationInSeconds` (e.g., `3600` for 1 hour) as a constructor argument.
3. **Interact:** * Add candidates using `addCandidate`.
* Authorize yourself or others using `chairPerson`.
* Vote using the candidate index (starting from 0).

---