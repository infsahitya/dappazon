// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    address public storeOwner;
    string public contractName;

    constructor(string memory initContractName) {
        contractName = initContractName;
        storeOwner = msg.sender;
    }

    function getContractName() public view returns (string memory) {
        return contractName;
    }

    function getStoreOwner() public view returns (address) {
        return storeOwner;
    }

    // TODO: List Products
    function listProducts(
        uint256 _id,
        uint256 _cost,
        uint256 _stock
        uint256 _rating,
        string memory _name,
        string memory _image,
        string memory _category,
    ) public {

    }

    // TODO: Buy Products
    function buyProduct() public {
    
    }

    // TODO: Withdraw Funds
    function withdrawFunds() public {
    
    }
}
