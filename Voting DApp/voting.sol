//SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;

contract VoteDapp{

    event Vote(address indexed user, string candidate,string message );
    event AddCandidate(string name, string party,string message);

    address private owner;
    uint startVote;
    uint endVote;
    uint highestVoteCount;
    uint leadingCandidateId;

    /*constructor to set the time slot for election 
    and setting the owner of the contract*/
    constructor(uint _durationInSeconds){
        owner = msg.sender;
        startVote = block.timestamp;
        endVote = block.timestamp + _durationInSeconds;
    }

    //struct to store the data of a candidate 
    struct candidate{
        string name;
        uint voteCount;
        string party;
    }

    //array to store multiple candidates
    candidate[] private candidates;

    //mapping address of user to the boolean value for security check
    mapping(address => bool) hasVoted;

    mapping(address => bool) canVote;

    /*onlyOwner helps in adding some functionality to DApp 
    that can be done by smart contract deployer only*/
    modifier onlyOwner(){
        require(owner == msg.sender,"You are not the owner");
        _;
    }

    //to ensure that the voting is done in the give timeslot only
    modifier onlyDuringElection() {
        require(block.timestamp >= startVote, "Election has not started yet.");
        require(block.timestamp <= endVote, "Election has already ended.");
        _;
    }

    /*function to add the candidate that are elected or nominated 
    can only be done by owner of smart contract*/
    function addCandidate(string memory _name, string memory _party) public onlyOwner{
        candidates.push(candidate({
            name : _name,
            voteCount : 0,
            party : _party
        }));
        emit AddCandidate(_name, _party, "Candidate added successfully");
    }

    //for user to view the candidates whome to vote using indexes
    function viewCandidate()public view returns(candidate[] memory){
        return candidates;
    }
    
        function chairPerson(address _userAdd) public onlyOwner{
        canVote[_userAdd] = true;
    }

    //function for users to vote for their candidate
    function vote(uint _i)public onlyDuringElection{
        require(_i < candidates.length ,"the candidate do not exist");  //to check whether the candidate exists or not
        require(canVote[msg.sender], "You are not authorized to vote.");
        require(hasVoted[msg.sender] == false,"You already voted:");    //to check whether the user had already voted 
        hasVoted[msg.sender] = true;
        candidates[_i].voteCount +=1;
        // If this candidate now has more votes than the current leader, they become the leader.
        if (candidates[_i].voteCount > highestVoteCount) {
            highestVoteCount = candidates[_i].voteCount;
            leadingCandidateId = _i;
        }
        emit Vote(msg.sender, candidates[_i].name, "Vote successfull");
    }
    //function to get the winner after the end of election
    function checkWinner() view public returns(string memory){
        require(block.timestamp > endVote, "Election is still ongoing. Results are hidden!");
        require(candidates.length != 0, "No candidates available");
        require(highestVoteCount > 0, "No votes have been cast yet.");
        return candidates[leadingCandidateId].name;
    }
}