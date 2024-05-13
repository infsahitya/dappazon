const { expect } = require("chai")

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

const contractName = "Dappazon";

describe("Dappazon", () => {
  it("has a name", async () => {
    const Dappazon = await ethers.getContractFactory("Dappazon");
    dappazon = await Dappazon.deploy(contractName);

    expect(await dappazon.getContractName()).to.equal(contractName);
  })
})
