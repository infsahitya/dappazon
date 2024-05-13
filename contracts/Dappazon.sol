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
}
