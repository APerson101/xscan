import {AccountBalanceQuery, AccountCreateTransaction, AccountId, Client, FileAppendTransaction, FileContentsQuery, FileCreateTransaction, FileId, Hbar, PrivateKey, TokenCreateTransaction, TokenId, TokenSupplyType, TokenType, TransferTransaction} from "@hashgraph/sdk";
import * as dotenv from "dotenv";

dotenv.config({path: "../.env"});


export async function createnewAccount(client: Client) {
  var privateKey = PrivateKey.generateED25519();
  var publicKey = privateKey.publicKey;
  var accountTransaction = (await new AccountCreateTransaction()
    .setKey(publicKey)
    .setInitialBalance(Hbar.fromTinybars(3000))
    .execute(client));
  var accountId = (await accountTransaction.getReceipt(client)).accountId;
  return {'accountID': accountId?.toString(), 'privateKey': privateKey.toStringRaw()};
}

// In the form of an NFT receipt
export async function createOwnersShipReceipt(client: Client, name: string, symbol: string,
) {
  const accountID = `${process.env.ACCOUNT_ID}`;
  const privateKey = `${process.env.PRIVATE_KEY}`;
  // const supplyKey = PrivateKey.generate();
  const barCodeInfo = new TokenCreateTransaction()
    .setTokenName(name)
    .setTokenSymbol(symbol)
    .setTokenType(TokenType.NonFungibleUnique)
    .setDecimals(0)
    .setInitialSupply(0)
    .setTreasuryAccountId(accountID)
    .setSupplyKey(PrivateKey.fromString(privateKey))
    .setSupplyType(TokenSupplyType.Finite)
    .setMaxSupply(1)
    .freezeWith(client);
  const signed = await barCodeInfo.sign(PrivateKey.fromStringED25519(privateKey));
  const executed = await signed.execute(client);
  const receipt = await executed.getReceipt(client);
  const tokenID = receipt.tokenId!;
  console.log("The token is id ", tokenID.toString());
  return tokenID.toString();
}


// Transfer the NFT receipt ownership
export async function transferReceiptOwnership(client: Client, tokenID: TokenId, senderID: string, receiver: string, senderKey: PrivateKey) {
  const tokenTransferTx = await new TransferTransaction()
    .addNftTransfer(tokenID, 1, AccountId.fromString(senderID), AccountId.fromString(receiver))
    .freezeWith(client)
    .sign(senderKey);

  // const tokenTransferSubmit =
  await tokenTransferTx.execute(client);
  // const tokenTransferRx = await tokenTransferSubmit.getReceipt(client);
}

export async function storeBarcodeInFile(client: Client, key: PrivateKey,
  text: string) {
  const barCodeInfo = new FileCreateTransaction()
    .setKeys([key])
    .setContents(text)
    .setMaxTransactionFee(new Hbar(2))
    .freezeWith(client);
  const signed = await barCodeInfo.sign(key);
  const executed = await signed.execute(client);
  const receipt = await executed.getReceipt(client);
  const fileID = receipt.fileId;
  console.log("The token is id ", fileID);
  return fileID?.toString();
}


export async function appendFile(client: Client, file: FileId, content: string, fileKey: PrivateKey) {
  // Create the transaction
  const transaction = new FileAppendTransaction()
    .setFileId(file)
    .setContents(content)
    .setMaxTransactionFee(new Hbar(2))
    .freezeWith(client);

  const signTx = await transaction.sign(fileKey);

  const txResponse = await signTx.execute(client);

  const receipt = await txResponse.getReceipt(client);

  const transactionStatus = receipt.status;

  console.log("The transaction consensus status is " + transactionStatus);
}

export async function retrieveFileContent(client: Client, fileId: FileId) {
  const query = new FileContentsQuery()
    .setFileId(fileId);
  const contents = await query.execute(client);
  return contents.toString();
}

export async function sendFunds(client: Client, senderAccountid: AccountId,
  senderPrivateKey: PrivateKey, amount: number, receiverAccountID: AccountId) {
  var receipt = await (await (await new TransferTransaction()
    .addHbarTransfer(senderAccountid, Hbar.fromTinybars(-amount))
    .addHbarTransfer(receiverAccountID, Hbar.fromTinybars(amount))
    .freezeWith(client)
    .sign(senderPrivateKey))
    .execute(client)).getReceipt(client);
  console.log(`sending funds from ${senderAccountid} to ${receiverAccountID} is ${receipt.status}`);
  return receipt.status;
}


export async function getAccountBalance(client: Client, accountID: AccountId) {
  const accountBalance = await new AccountBalanceQuery()
    .setAccountId(accountID)
    .execute(client);
  return accountBalance.hbars.toTinybars();
}

// async function main() {
//   const client = await setup();
//   var key = PrivateKey.generate();
//   // await createOwnersShipReceipt(client);  // works: DONE

//   var fileID = await storeBarcodeInFile(client, key);

//   await appendFile(client, fileID, "hello world", key);

//   await retrieveFileContent(client, fileID);

// }
