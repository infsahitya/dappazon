// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    address private storeOwner;
    string private contractName;

    struct Item {
        uint256 id;
        string name;
        string image;
        uint256 cost;
        uint256 stock;
        uint256 rating;
        string category;
    }

    uint256 private totalItems;
    mapping(uint256 => Item) private items;

    constructor(string memory initContractName) {
        contractName = initContractName;
        storeOwner = msg.sender;

        totalItems = 0;
    }

    // TODO: Get deployed contract's name
    function getContractName() public view returns (string memory) {
        return contractName;
    }

    // TODO: Get deployers address
    function getStoreOwner() public view returns (address) {
        return storeOwner;
    }

    // TODO: Get Product
    function getProduct(uint256 _id) public view returns (Item memory) {
        return items[_id];
    }

    // TODO: Add Product
    function addProduct(
        uint256 _id,
        uint256 _cost,
        uint256 _stock,
        uint256 _rating,
        string memory _name,
        string memory _image,
        string memory _category
    ) public {
        Item memory item = Item(
            _id,
            _name,
            _image,
            _cost,
            _stock,
            _rating,
            _category
        );

        items[_id] = item;
    }

    // TODO: Buy Products
    function buyProduct() public {}

    // TODO: Withdraw Funds
    function withdrawFunds() public {}

    // TODO: List Products
    function listProducts() public view returns (Item[] memory) {
        Item[] memory productsList = new Item[](totalItems);

        for (uint256 i = 0; i < totalItems; i++) {
            productsList[i] = items[i];
        }

        return productsList;
    }
}
