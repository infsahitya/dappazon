// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const HRE = require("hardhat");
const { ethers } = HRE;

const { items } = require("../src/items.json");

const contractName = "Dappazon";

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
};

async function main() {
  const [deployer] = await ethers.getSigners();

  const Dappazon = await ethers.getContractFactory(contractName);
  const dappazon = await Dappazon.connect(deployer).deploy(contractName);

  await dappazon.deployed();

  console.log(`Deployed Dappazon Contract at: ${dappazon.address}`);

  items.forEach(async (item) => {
    const transaction = await dappazon
      .connect(deployer)
      .addProduct(
        item.id,
        tokens(item.cost),
        item.stock,
        item.rating,
        item.name,
        item.image,
        item.category,
      );

    await transaction.wait();

    console.log(`Added Item ${item.id} - ${item.name}`);
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
