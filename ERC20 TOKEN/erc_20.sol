//SPDX-License-Identifier:MIT
pragma solidity ^0.8.30;

contract ERC20 {
    // --- State Variables ---
    string public name;             // Name of the token (e.g., "MyToken")
    string public symbol;           // Short symbol (e.g., "MTK")
    uint public totalToken;         // Total supply in raw units
    address owner;                  // Address of the contract creator
    uint8 public decimals;          // Decimal places (usually 18)

    // --- Events ---
    // Emitted when tokens move from one account to another
    event Transfer(address indexed _from, address indexed _to, uint _amount);
    // Emitted when an owner approves a spender to use tokens
    event Approval(address indexed owner, address indexed spender, uint value);

    // --- Mappings ---
    mapping(address => uint) public balance;                             // Tracks user balances
    mapping(address => mapping(address => uint)) public allowed;        // Tracks approved spending limits

    // --- Modifiers ---
    // Restricts access to only the contract owner
    modifier onlyOwner(){
        require(owner == msg.sender, "You are not the owner");
        _;
    }
    
    // --- Constructor ---
    constructor(string memory _name, string memory _symbol, uint _totalSupply, uint8 _decimal){
        name = _name;
        symbol = _symbol;
        decimals = _decimal;
        totalToken = _totalSupply * 10** _decimal;      // Convert human supply to raw units
        owner = msg.sender;                             // Set deployer as owner
        balance[msg.sender] = totalToken;               // Give all initial tokens to the creator
    }

    // --- Functions ---

    // Creates new tokens (Owner only)
    function mint(uint _amount) public onlyOwner {
        totalToken += _amount * 10** decimals;          // Increase total supply
        balance[owner] += _amount * 10** decimals;      // Add units to owner's balance
        emit Transfer(address(0), owner, _amount);      // Log creation from the zero address
    }

    // Returns total supply of tokens
    function totalSupply() public view returns(uint){
        return (totalToken);
    }

    // Transfers tokens from the caller to another address
    function transfer(address _to, uint _amount) public returns(bool){
        require(balance[msg.sender] >= _amount, "Insufficient Balance"); // Check sender has enough
        require(_to != address(0), "Address not valid");                // Prevent sending to zero address
        balance[_to] += _amount;                                        // Add to recipient
        balance[msg.sender] -= _amount;                                 // Subtract from sender
        emit Transfer(msg.sender, _to, _amount);                        // Log the move
        return true;
    }

    // Returns the balance of a specific address
    function balanceOf(address _user) public view returns(uint){
        return balance[_user];
    }

    // Authorizes a spender to use a certain amount of the caller's tokens
    function approve(address _spender, uint value) public {
        allowed[msg.sender][_spender] = value;          // Set the allowance limit
        emit Approval(msg.sender, _spender, value);     // Log the approval
    }

    // Checks how many tokens an owner has allowed a spender to use
    function allowance(address _spender, address _owner) public view returns(uint){
        return allowed[_owner][_spender];
    }

    // Moves tokens from one account to another using the allowance mechanism
    function transferFrom(address _owner, address _to, uint _amount) public returns(bool) {
        require(balance[_owner] >= _amount, "Insufficient Balance");            // Check owner has tokens
        require(allowed[_owner][msg.sender] >= _amount, "Allowance exceeded");  // Check spender is authorized
        require(_to != address(0), "Address not valid");                       // Prevent sending to zero address
        
        balance[_to] += _amount;                        // Add to recipient
        allowed[_owner][msg.sender] -= _amount;         // Deduct from spender's budget
        balance[_owner] -= _amount;                     // Deduct from owner's balance
        emit Transfer(_owner, _to, _amount);            // Log the move
        return true;
    }

    // Destroys tokens from the caller's wallet permanently
    function burn(uint _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient Balance"); // Check caller has tokens
        balance[msg.sender] -= _amount;                                 // Subtract from caller
        totalToken -= _amount;                                          // Reduce total supply
        emit Transfer(msg.sender, address(0), _amount);                 // Log burn as move to zero address
    }
}