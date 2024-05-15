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

    struct Order {
        uint256 time;
        Item item;
    }

    mapping(uint256 => Item) private items;
    uint256[] private ItemIDs;

    mapping(address => uint256) private orderCounts;
    mapping(address => mapping(uint256 => Order)) private orders;

    constructor(string memory initContractName) {
        contractName = initContractName;
        storeOwner = msg.sender;
    }

    // TODO: EVENT - emit information about added product
    event AddProduct(uint256 _id, string _name, uint256 _stock);

    // TODO: EVENT - emit information about order & purchase
    event BuyProduct(address _buyer, uint256 _ordersCount, uint256 _itemID);

    // TODO: MODIFIER - check only for owner/deployer of the contract
    modifier onlyOwner() {
        require(
            storeOwner == msg.sender,
            "Only deployer of the contract can add a product"
        );
        _;
    }

    // TODO: MODIFIER - check for available stock
    modifier stockAvailability(uint256 _id) {
        require(
            items[_id].stock > 0,
            "No stock available for the desired item"
        );
        _;
    }

    // TODO: MODIFIER - check of minimum amount to purchase item
    modifier minimumAmount(uint256 _id) {
        require(
            msg.value >= items[_id].cost,
            "Miniumum amount required to place order"
        );
        _;
    }

    // TODO: FUNCTION - get deployed contract's name
    function getContractName() public view returns (string memory) {
        return contractName;
    }

    // TODO: FUNCTION - get contract's deployer's address
    function getStoreOwner() public view returns (address) {
        return storeOwner;
    }

    // TODO: FUNCTION - get details about a product using ID
    function getProduct(uint256 _id) public view returns (Item memory) {
        return items[_id];
    }

    // TODO: FUNCTION - get order count of one user
    function getOrderCount() public view returns (uint256) {
        return orderCounts[msg.sender];
    }

    // TODO: FUNCTION - get order details
    function getOrder(uint256 _id) public view returns (Order memory) {
        return orders[msg.sender][_id];
    }

    // TODO: FUNCTION - add a product to mapping
    function addProduct(
        uint256 _id,
        uint256 _cost,
        uint256 _stock,
        uint256 _rating,
        string memory _name,
        string memory _image,
        string memory _category
    ) public onlyOwner {
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
        ItemIDs.push(_id);

        emit AddProduct(_id, _name, _stock);
    }

    // TODO: FUNCTION - buy a product
    function buyProduct(
        uint256 _id
    ) public payable stockAvailability(_id) minimumAmount(_id) {
        Item memory item = items[_id];

        Order memory order = Order(block.timestamp, item);

        uint256 newOrderID = ++orderCounts[msg.sender];
        orders[msg.sender][newOrderID] = order;

        items[_id].stock -= 1;

        emit BuyProduct(msg.sender, newOrderID, item.id);
    }

    // TODO: FUNCTION - withdraw the funds
    function withdrawFunds() public onlyOwner {
        (bool success, ) = storeOwner.call{value: address(this).balance}("");
        require(success);
    }

    // TODO: FUNCTION - list all the products stored in mapping
    function listProducts() public view returns (Item[] memory) {
        uint256 totalItems = ItemIDs.length;
        Item[] memory productsList = new Item[](totalItems);

        for (uint256 i = 0; i < totalItems; i++) {
            productsList[i] = items[ItemIDs[i]];
        }

        return productsList;
    }
}
