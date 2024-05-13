// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    string public contractName;

    constructor(string memory initContractName) {
        contractName = initContractName;
    }

    function getContractName() public view returns (string memory) {
        return contractName;
    }
}
