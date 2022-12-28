const Web3 = require("web3");
const dotenv = require("dotenv");
dotenv.config();
const contract_abi = require("./artifacts/FundMe_metadata.json");

const main = async () => {
  var web3 = await new Web3(process.env.REACT_APP_ethereum_provider);
  var wallet = web3.eth.accounts.privateKeyToAccount(
    process.env.REACT_APP_Private_key
  );
  var contract = new web3.eth.Contract(
    contract_abi.output.abi,
    process.env.REACT_APP_CONTRACTADDRESS
  );
  const ethAmount = web3.utils.toWei("50", "ether");
  let tx = await contract.methods.getETHPriceInUSD().call();
  tx = await contract.methods.convertEthAmountInUSD(ethAmount);
  console.log("tx", tx);
};
main();
