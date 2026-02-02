//SPDX-License-Identifier:MIT

pragma solidity ^0.8.30;

contract smartWareHouse{

    event addProduct(string message);

    enum Status{
        OutOfStock,     //maps to 0
        Available,      //maps to 1
        Discontinued    //maps to 2
    }
    struct Product{
        string name;
        uint price;
        uint id;
        Status status;
    }
    address private owner;
    Product[] public items;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner , "NOT the contract Owner");
        _;
    }

    //function to add products to warehouse:
    function addProducts(string memory _name, uint _price, Status _status)public onlyOwner{
        items.push(Product({
            name : _name,
            price : _price,
            id : block.timestamp,
            status : _status
        }));
        emit addProduct("Product Sucessfully Added");
    }

    //function to update the status of the products in warehouse:
    function updateStatus(uint _i, Status _newStatus) public onlyOwner{
        require(_i < items.length, "index out of bound");
        items[_i].status = _newStatus;
    }

    //function to count the total number of products in warehouse:
    function countProduct() view public returns(uint){
        uint count = 0;
        for(uint i = 0; i<items.length;i++){
            if(items[i].status == Status.Available){
                count++;
            }
        }
        return(count);        
    }
}