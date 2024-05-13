const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
};

const contractName = "Dappazon";

describe("Dappazon", () => {
  let dappazon;
  let buyer, deployer;

  beforeEach(async () => {
    [deployer, buyer] = await ethers.getSigners();

    const Dappazon = await ethers.getContractFactory(contractName);
    dappazon = await Dappazon.deploy(contractName);
  });

  describe("Deployment", () => {
    it(`Contract - ${contractName}`, async () => {
      const fetchedName = await dappazon.getContractName();
      expect(fetchedName).to.equal(contractName);
    });

    it(`${contractName} Owner`, async () => {
      const fetchedOwner = await dappazon.getStoreOwner();
      expect(fetchedOwner).to.be.equal(deployer.address);
    });
  });
});
