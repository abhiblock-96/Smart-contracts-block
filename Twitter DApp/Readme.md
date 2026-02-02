This project is a basic implementation of a Twitter-like system on the Ethereum blockchain using Solidity. It allows for user registration, tweet creation, and a like/unlike system for tweets.

A key feature of this specific contract is that only the contract owner can post tweets, which are then associated with their address. Other users can register an account, view all tweets, and like/unlike any tweet.

✨ Features
 * User Registration: Users can register their address with a name and age.
 * Owner-Only Tweeting: The contract owner can create tweets (up to a MAX_LENGTH).
 * Admin Control: The owner can change the maximum tweet length at any time.
 * Like/Unlike System: Any address can like or unlike any tweet, provided they know the author's address and tweet ID.
 * Tweet Viewing: Anyone can view all tweets from a specific author or query a single tweet.
 * Event Emission: Emits events for key actions like user registration, tweet creation, and likes/unlikes, making it easy to build a frontend that listens for these changes.
   
⚙️ Contract API & Functions

Here is a breakdown of the core functions available in the contract.
Admin (Owner-Only) Functions
These functions can only be called by the address that deployed the contract.
 * constructor()
   * Sets the deployer (msg.sender) as the owner of the contract.
 * changeTweetLength(uint newTwetLength)
   * Allows the owner to update the MAX_LENGTH (in bytes) allowed for a tweet.
 * createTweet(string memory _tweet)
   * Allows the owner to create a new tweet. The tweet is stored under the owner's address.
   * Requires the tweet to be longer than 0 bytes and shorter than or equal to MAX_LENGTH.
   * Emits a TweetCreated event.
User Functions
 * addUser(string memory _name, uint _age)
   * Registers the caller (msg.sender) as a new user, storing their _name and _age.
   * Emits a newUserRegister event.
Like/Unlike Functions
These functions can be called by any address.
 * addLikes(uint _id, address _author)
   * Adds a 'like' to a specific tweet.
   * Requires the tweet _id (its index in the author's array) and the _author's address.
   * Emits a tweetLiked event.
 * removeLike(uint _id, address _author)
   * Removes a 'like' from a specific tweet.
   * Requires the tweet to exist and have at least one like.
   * Emits a tweetUnLiked event.
View Functions (Public)
These are read-only functions that do not consume gas (if called externally) and can be called by anyone.
 * viewAllTweet(address _owner)
   * Returns an array of all TweetData structs for a given _owner address.
 * viewTweet(address _owner, uint i)
   * Returns a single, specific TweetData struct from an _owner's tweet array by its index i.
 * viewsome(uint _id)
   * A convenience function that returns the like count and content for one of the caller's (msg.sender) own tweets, specified by its _id.
 * totalLikes(address _author)
   * Returns the total cumulative like count for all tweets by a specific _author.
   
🔔 Events

The contract emits the following events, which can be monitored by off-chain applications:
 * newUserRegister(address indexed user, string name)
   * Emitted when a new user calls addUser.
 * TweetCreated(uint indexed id, address author, string content, uint timestamp)
   * Emitted when the owner successfully creates a new tweet.
 * tweetLiked(address liker, address author, uint tweetId, uint totalLikeCount)
   * Emitted when addLikes is successfully called.
 * tweetUnLiked(address liker, address author, uint tweetId, uint totalLikeCount)
   * Emitted when removeLike is successfully called.
   
🚀 How to Use
 * Deploy: Deploy the contract using a tool like Remix, Hardhat, or Foundry. The wallet that deploys it will be the owner.
 * Create Tweets (Owner): The owner can now call createTweet() to post content.
 * Register (Users): Any other user can call addUser() to register themselves.
 * Interact: Any user can call viewAllTweet() (passing in the owner's address) to see the tweets and use addLikes() or removeLike() to interact with them.

📄 License
This project is licensed under the MIT License. See the SPDX-License-Identifier at the top of the contract file.