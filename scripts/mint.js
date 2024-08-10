require('dotenv').config();
const hre = require("hardhat");
const { encryptDataField } = require("@swisstronik/utils");

const sendShieldedTransaction = async (signer, destination, data, value) => {
  const rpcLink = hre.network.config.url;

  const [encryptedData] = await encryptDataField(rpcLink, data);

  return await signer.sendTransaction({
    from: signer.address,
    to: destination,
    data: encryptedData,
    value,
  });
};

async function main() {
  const [signer] = await hre.ethers.getSigners();

  const contractAddress = "0xCcA179c31f738fA6E529D5a782746B1c74Cf8508";
  const AneemaCollection = await hre.ethers.getContractFactory("AneemaCollection");
  const aneemaCollection = AneemaCollection.attach(contractAddress);

  const baseMetadataUrl = "https://beige-patient-cicada-388.mypinata.cloud/ipfs/QmebbdFcwE75BZGYMsgMqrGYHtNCE1pjr52ygKfLX7aEeo/";

  try {
    for (let tokenId = 1; tokenId <= 40; tokenId++) {
      const metadataUrl = `${baseMetadataUrl}${tokenId}.json`;
      const recipientAddress = "0x86f0A36D94F7Ff80de694a23e045f4ecf5d304cC";

      const data = aneemaCollection.interface.encodeFunctionData("mintTo", [recipientAddress, metadataUrl]);

      const tx = await sendShieldedTransaction(signer, contractAddress, data, 0);
      await tx.wait();
      console.log(tx.hash)
      
      console.log(`Minted NFT #${tokenId} with metadata URL ${metadataUrl}`);
    }
  } catch (err) {
    console.error('Error minting NFTs:', err);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
