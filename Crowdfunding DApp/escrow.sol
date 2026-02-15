// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title Escrow Crowdfunding Contract
 * @dev Implements a basic crowdfunding logic with deadline and goal-based payouts.
 */
contract Escrow {
    // --- State Variables ---
    uint public goalAmount;               // Target amount to be raised (in wei)
    uint public startTime = block.timestamp; 
    uint public endTime;                  // Timestamp when the campaign expires
    uint public raisedAmount;             // Total funds collected through the fund() function
    address owner;                        // The creator who can withdraw funds upon success

    // --- Events ---
    // Triggered when a user contributes
    event funded(address user, uint amount);
    // Triggered when the owner successfully withdraws the pot
    event GoalReached(uint total);

    /**
     * @param _amount The fundraising goal in wei
     * @param _duration The length of the campaign in seconds
     */
    constructor(uint _amount, uint _duration) {
        goalAmount = _amount;
        endTime = startTime + _duration;
        owner = msg.sender;
    }

    // --- Mappings ---
    // Tracks how much Ether each address has contributed
    mapping(address => uint) contribution;

    // --- Modifiers ---
    // Restricts access to only the contract creator
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // Ensures the action happens before the deadline
    modifier Deadline() {
        require(block.timestamp <= endTime, "Contributions are closed");
        _;
    }

    /**
     * @notice Allows users to contribute Ether to the project
     * @dev Updates both individual mapping and total raised counter
     */
    function fund() external payable Deadline returns(bool) {
        contribution[msg.sender] += msg.value;
        raisedAmount += msg.value;
        emit funded(msg.sender, msg.value);
        return true;
    }

    /**
     * @notice Returns total funds raised (Only callable by owner)
     */
    function checkStatus() external view onlyOwner returns(uint) {
        return raisedAmount;
    }

    /**
     * @notice Allows a user to check their own total contribution
     */
    function checkContribution() external view returns(uint) {
        return contribution[msg.sender];
    }

    /**
     * @notice Allows contributors to get their money back if the goal is NOT met
     * @dev Follows Checks-Effects-Interactions pattern to prevent reentrancy
     */
    function getRefund() external {
        // Check: Has the time run out and did the project fail?
        require(block.timestamp > endTime, "Contribution is still going on");
        require(raisedAmount < goalAmount, "Not eligible to refund");
        require(contribution[msg.sender] != 0, "Not enough balance");

        // Effect: Capture balance and reset mapping to zero BEFORE sending
        uint totalRefund = contribution[msg.sender];
        contribution[msg.sender] = 0;

        // Interaction: Send the Ether back
        (bool success, ) = (msg.sender).call{value: totalRefund}("");
        require(success, "Transfer failed");
    }

    /**
     * @notice Allows owner to claim all funds if the goal is met
     * @dev Sends the entire contract balance to the owner
     */
    function withdraw() external onlyOwner {
        // Check: Has the time run out and was the goal hit?
        require(block.timestamp > endTime, "Contribution is still going on");
        require(raisedAmount >= goalAmount, "Goal not reached yet");

        uint contractBalance = address(this).balance;
        
        // Interaction: Transfer all funds held by the contract
        (bool success, ) = owner.call{value: contractBalance}("");
        require(success, "Transfer failed");

        emit GoalReached(contractBalance);
    }
}