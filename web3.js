const Web3 = require("web3");
require("dotenv").config();
const contract_abi = require("./artifacts/FundMe_metadata.json");

const main = async () => {
  const web3 = new Web3(process.env.ETHEREUM_NODE);
  const wallet = web3.eth.accounts.wallet.add(process.env.PRIVATE_KEY);
  let contract = new web3.eth.Contract(
    contract_abi.output.abi,
    process.env.CONTRACT_ADDRESS
  );
  const ethAmount = web3.utils.toWei("50", "ether");
  //   console.log("ethAmount", ethAmount);
  let tx = await contract.methods
    .convertEthAmountInUSD(ethAmount)
    .send({ from: wallet.address, gas: 10000000 });
  console.log("Transaction", tx);
};
main();
