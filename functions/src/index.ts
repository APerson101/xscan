import {AccountId, Client, FileId, PrivateKey, TokenId} from "@hashgraph/sdk";
import * as admin from "firebase-admin";
import {MulticastMessage} from "firebase-admin/lib/messaging/messaging-api";
import * as functions from "firebase-functions";
import * as hash from "./hashgraph/hash";
// const serviceAccount = require("../keypair.json");
// admin.initializeApp({credential: admin.credential.cert(String(serviceAccount))})

// dotenv.config({path: "../.env"});

const accountID = `${process.env.ACCOUNT_ID}`;
const privateKey = `${process.env.PRIVATE_KEY}`;
function getClient() {
  const client = Client.forTestnet();
  client.setOperator(accountID, privateKey);
  return client;
}
export const createAccount = functions.https.onCall(async (ref) => {
  return await hash.createnewAccount(getClient());
});
export const createNFTReceipt = functions.https.onCall(async (req) => {
  const client = getClient();
  const data = req.data;
  const name = data.brandName;
  const symbol = data.brandSymbol;
  const nftId = await hash.createOwnersShipReceipt(client, name, symbol);
  await hash.transferReceiptOwnership(client, TokenId.fromString(nftId), accountID,
    data.receiver, PrivateKey.fromString(privateKey));
  return nftId;
});
export const transferItemNftOwnership = functions.https.onCall(async (req) => {
  const data = req.data;
  const id = data.nftId;
  const sender = data.sender;
  const receiver = data.receiver;
  const senderpk = data.senderPrivateKey;
  const client = getClient();

  await hash.transferReceiptOwnership(client, id, sender,
    receiver, PrivateKey.fromString(senderpk));
  return true;
});
export const storeBarcodeInFile = functions.https.onCall(async (req) => {
  const data = req.data;
  const creatorPK = data.pk;
  const text = data.text;
  const client = getClient();

  return await hash.storeBarcodeInFile(client, PrivateKey.fromString(creatorPK), text);
});
export const appendFile = functions.https.onCall(async (req) => {
  const data = req.data;
  const creatorPK = data.pk;
  const content = data.text;
  const fileId = data.fileId;
  const client = getClient();
  await hash.appendFile(client, FileId.fromString(fileId), content, PrivateKey.fromString(creatorPK));
  return true;
});
export const getFileContent = functions.https.onCall(async (req) => {
  const data = req.data;
  const fileId = data.fileId;
  const client = getClient();
  return await hash.retrieveFileContent(client, FileId.fromString(fileId),);
});

export const sendNotification = functions.https.onCall(async (req) => {
  const tokens = req.tokens;
  const message: MulticastMessage = {
    tokens: tokens,
    data: req.data
  }
  await admin.messaging().sendEachForMulticast(message);
  return;
});
export const transferHbarEscrow = functions.https.onCall(async (req) => {
  const senderAccountid = req.senderAccountid;
  const senderPrivateKey = req.senderPrivateKey;
  const amount = req.amount;
  return await hash.sendFunds(getClient(),
    AccountId.fromString(senderAccountid),
    PrivateKey.fromString(senderPrivateKey),
    amount,
    AccountId.fromString(accountID),
  );
});



export const getAccountBalance = functions.https.onCall(async (req) => {
  const accountID = req.accountID;
  return await hash.getAccountBalance(getClient(), accountID);
});

export const approveEscrowTransfer = functions.https.onCall(async (req) => {
  const receiverAccountID = req.receiverAccountID;
  return await hash.sendFunds(getClient(), AccountId.fromString(accountID),
    PrivateKey.fromString(privateKey), req.amount, AccountId.fromString(receiverAccountID));
});
// export const deleteuser = functions.https.onCall(async (req) => {
//   const data = req.data;
//   const id = data.id;
//   await admin.auth().deleteUser(id)
// });
