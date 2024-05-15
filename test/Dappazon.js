const { expect } = require("chai");
const { ethers } = require("hardhat");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
};

const contractName = "Dappazon";

const dummyProduct = {
  id: 1,
  rating: 4,
  stock: 999,
  name: "Keyboard",
  cost: tokens(1),
  category: "Electronics",
  image: "Keyboard <> Image",
}

const addProductEventName = "AddProduct";

describe("Dappazon", () => {
  let dappazon;
  let buyer, deployer;

  beforeEach(async () => {
    [deployer, buyer] = await ethers.getSigners();

    const Dappazon = await ethers.getContractFactory(contractName);
    dappazon = await Dappazon.connect(deployer).deploy(contractName);
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

  describe("Add Product", () => {
    let transaction;

    beforeEach(async () => {
      transaction = await dappazon.connect(deployer).addProduct(
        dummyProduct.id,
        dummyProduct.cost,
        dummyProduct.stock,
        dummyProduct.rating,
        dummyProduct.name,
        dummyProduct.image,
        dummyProduct.category,
      );
      
      await transaction.wait();
    })

    it("Product Matched", async () => {
      const fetchedItem = await dappazon.getProduct(dummyProduct.id);
      expect(fetchedItem.id).to.be.equal(dummyProduct.id);
    })

    it("Event Emitted", async () => {
      expect(transaction).to.emit(dappazon, addProductEventName);
    })

    it("List Products", async () => {
      const fetchedItems = await dappazon.listProducts();
      expect(fetchedItems.length).to.be.equal(1);
      expect(fetchedItems[0].id).to.be.equal(dummyProduct.id);
    })
  })

  describe("Buy Product", async () => {
    let transaction;

    beforeEach(async () => {
      transaction = await dappazon.connect(deployer).addProduct(
        dummyProduct.id,
        dummyProduct.cost,
        dummyProduct.stock,
        dummyProduct.rating,
        dummyProduct.name,
        dummyProduct.image,
        dummyProduct.category,
      );
      await transaction.wait();

      transaction = await dappazon.connect(buyer).buyProduct(dummyProduct.id, { value: dummyProduct.cost });
      await transaction.wait();
    })

    it("Contract balance for only one product of 1 ETH", async () => {
      const result = await ethers.provider.getBalance(dappazon.address);
      console.log(result);
      expect(result).to.be.equal(dummyProduct.cost);
    })
  })  
});
