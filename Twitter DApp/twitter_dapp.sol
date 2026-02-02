//SPDX-License-Identifier:MIT

pragma solidity^0.8.30;

contract twitter{
    uint MAX_LENGTH = 200;
    address owner;

        //Rergister a new user::
    event newUserRegister(address indexed user, string name);

    struct newUser{
        string name;
        uint age;
    }
    mapping(address => newUser) users;

    function addUser(string memory _name , uint _age)  public {
        newUser storage user1 = users[msg.sender];      //maps the user to address::
        user1.name = _name;
        user1.age = _age;
        emit newUserRegister(msg.sender, _name);
    }

        //tweet structure here::
    event TweetCreated(uint indexed id ,address author,string content, uint timestamp);

    struct TweetData{
        uint id;
        address owner;
        string content;
        uint time;
        uint like;
    }
    mapping(address =>TweetData[] ) tweets;


    constructor(){
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(owner == msg.sender , "You are not the owner");
        _;
    }

        // owner setting up the length limits:
    function changeTweetLength(uint newTwetLength) public onlyOwner{
        MAX_LENGTH = newTwetLength;
    }
        // Creating tweets:
    function createTweet(string memory _tweet) public onlyOwner {

        require(bytes(_tweet).length <= MAX_LENGTH , "tweet too long");
        require(bytes(_tweet).length > 0 , "tweet too short");


        TweetData memory tweet = TweetData({
            id:tweets[msg.sender].length,
            owner:msg.sender,
            content:_tweet,
            time:block.timestamp,
            like:0               
        });

        tweets[msg.sender].push(tweet);

        emit TweetCreated(tweets[msg.sender].length, msg.sender, _tweet, block.timestamp);
    }

    function viewAllTweet(address _owner) public view returns (TweetData[] memory){
        return tweets[_owner];
    }

        function viewTweet(address _owner,uint i) public view returns (TweetData memory){
        return tweets[_owner][i];
    }
        //liking a tweet
    event tweetLiked(address liker , address author , uint tweetId , uint totalLikeCount );

    function addLikes(uint _id, address _author) external {
        require(tweets[_author][_id].id==_id , "Tweet not Exist");
        tweets[_author][_id].like++ ;
        emit tweetLiked(msg.sender, _author, _id, tweets[_author][_id].like);
    }
        //unlike the tweets:
    event tweetUnLiked(address liker , address author , uint tweetId , uint totalLikeCount );
    function removeLike(uint _id , address _author) external{
        require(tweets[_author][_id].id==_id , "Tweet not Exist");
        require(tweets[_author][_id].like>0 , "No Likes Given");
        tweets[_author][_id].like-- ;
        emit tweetUnLiked(msg.sender, _author, _id, tweets[_author][_id].like);
    }
        //view particular tweet with specific parameters::
    function viewsome(uint _id) public view returns(uint , string memory){
        return (tweets[msg.sender][_id].like,tweets[msg.sender][_id].content);  //you can get single value from key of array struct mapping
    }

    function totalLikes(address _author) external view returns(uint){
        uint totallikes;
        for(uint i =0;i<tweets[_author].length; i++ ){
            totallikes+=tweets[_author][i].like;
        }
        return totallikes;
        }
}