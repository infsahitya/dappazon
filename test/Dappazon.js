const { expect } = require("chai");

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), "ether");
};

const contractName = "Dappazon";

describe("Dappazon", () => {
  let dappazon;

  beforeEach(async () => {
    const Dappazon = await ethers.getContractFactory(contractName);
    dappazon = await Dappazon.deploy(contractName);
  });

  describe("Deployment", () => {
    it("Contract Name", async () => {
      const fetchedName = await dappazon.getContractName();
      expect(fetchedName).to.equal(contractName);
    });
  });
});
