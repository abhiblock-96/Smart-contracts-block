//SPDX-License-Identifier:MIT

pragma solidity ^0.8.30;

contract ChatApp{
    struct user{
        string name;
        friend[] friendList;
    }
    struct friend{
        address pubKey;
        string name;
    }
    struct message{
        address sender;
        uint256 timestamp;
        string msg;
    }
    struct allUser{
        string name;
        address accountAddress;
    }
    allUser[] getAllUser;

    mapping(address => user) userList;
    mapping(bytes32 => message[]) allMessages;

    //check user exist or not:
    function checkUserExists(address pubkey) public view returns(bool){
        return bytes(userList[pubkey].name).length > 0;
    }

    //create account
    function createAccount(string calldata name) external {
        require(checkUserExists(msg.sender)==false,"User already exists");
        require(bytes(name).length >0 , "Username cannot be empty");

        userList[msg.sender].name = name;

        getAllUser.push(allUser(name , msg.sender));
    }

    function getUsername(address pubkey) external view returns(string memory){
        require(checkUserExists(pubkey),"User not registered");
        return userList[pubkey].name;
    }

    //ADD FRIEND
    function AddFriend(address friend_key , string calldata name) external{
        require(checkUserExists(friend_key), "Your friend is not registered");
        require(checkUserExists(msg.sender), "create an account first");
        require(msg.sender != friend_key , "User cannot add themselves as friend");
        require(checkAlreadyFriends(msg.sender , friend_key)==false , "theses users are already friends");

        _addFriend(msg.sender , friend_key , name);
        _addFriend(friend_key , msg.sender , userList[msg.sender].name);

    }
    //check Already friends
    function checkAlreadyFriends(address pubkey1 , address pubKey2)internal view returns(bool){
        if(userList[pubkey1].friendList.length>userList[pubKey2].friendList.length){
            address tmp =pubkey1;
            pubkey1 = pubKey2;
            pubKey2 = tmp;
        }
        for(uint256 i=0 ;i < userList[pubkey1].friendList.length ;i++){
            if(userList[pubkey1].friendList[i].pubKey == pubKey2)return true;
        }
        return false;
    }

    //ADD FRIENDS
    function _addFriend(address me , address friend_key , string memory name) internal{
        friend memory newFriend = friend(friend_key , name);
        userList[me].friendList.push(newFriend);
    }

    function getMyfriendList() external view returns(friend[] memory){
        return userList[msg.sender].friendList;
    }

    //get chat code
    function _getChatCode(address pubkey1 , address pubkey2) internal pure returns(bytes32){
        if(pubkey1 < pubkey2){
            return keccak256(abi.encodePacked(pubkey1,pubkey2));
        }
        else{
            return keccak256(abi.encodePacked(pubkey2 , pubkey1));
        }
    }

    //SEND MESSAGE
    function sendMessage(address friend_key , string calldata _msg) external{
        require(checkUserExists(friend_key), "User does not exist");
        require(checkUserExists(msg.sender) , "create account first");
        require(checkAlreadyFriends(msg.sender, friend_key) , "user is not friend of your's");

        bytes32 chatCode = _getChatCode(msg.sender, friend_key);
        message memory newMsg = message(msg.sender , block.timestamp , _msg);
        allMessages[chatCode].push(newMsg);
    }

    //READ MESSAGE
    function readMessage(address friend_key) external view returns(message[] memory){
        bytes32 chatCode = _getChatCode(msg.sender,friend_key);
        return allMessages[chatCode];
    }
    
    //fetch all user
    function getAllAppUser() public view returns(allUser[] memory){
        return getAllUser;
    }
}