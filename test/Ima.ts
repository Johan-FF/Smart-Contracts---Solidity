import { expect } from "chai";
import { ethers } from "hardhat";

describe("Ima Contract", function () {
  const setup = async (maxSupply: number = 10000) => {
    const [owner] = await ethers.getSigners();
    const contract = await ethers.deployContract("Ima", [maxSupply]);
    await contract.waitForDeployment();

    return {
      owner,
      contract,
    };
  };

  describe("Deploy", function () {
    it("Sets max supply to passed param", async function () {
      const maxSupply = 40;
      const { contract } = await setup(maxSupply);

      const returnedMaxSupply = await contract.maxSupply();
      expect(maxSupply).to.eq(returnedMaxSupply);
    });
  });

  describe("Minting", function () {
    it("Mints a new token and assings it to owner", async function () {
      const { owner, contract } = await setup();

      await contract.mint();

      const ownerOfMinted = await contract.ownerOf(0);

      expect(ownerOfMinted).to.eq(owner.address);
    });

    it("Has a minting limit", async function () {
      const maxSupply = 2;
      const { contract } = await setup(maxSupply);

      await Promise.all([contract.mint(), contract.mint()]);

      await expect(contract.mint()).to.be.revertedWith("No Ima left");
    });
  });

  describe("TokenURI", async function () {
    it("Returns valid metadata", async function () {
      const { contract } = await setup();

      await contract.mint();
      await contract.mint();

      const tokenURI = await contract.tokenURI(1);
      const stringifiedTokenURI = tokenURI.toString();
      const [, base64JSON] = stringifiedTokenURI.split(
        "data:application/json;base64,"
      );
      const stringifiedMetadata = Buffer.from(base64JSON, "base64").toString(
        "ascii"
      );

      const metadata = JSON.parse(stringifiedMetadata);
      expect(metadata).to.have.all.keys("name", "description", "image");
    });
  });
});
