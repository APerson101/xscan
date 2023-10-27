import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/models/transfer.dart';

import '../../worker/models/scanmodel.dart';
import '../models/txns_history.dart';
import 'db.dart';

typedef BalanceResponse = ({int hbar, TokensType tokens});
typedef TokensType = List<({String tokenId, int balance})>;
typedef NftInfo = ({
  List<String> imageLinks,
  String review,
  List<int> stars,
  String productName,
  Transfer tranfer,
  ItemOwnershipHistory ownership
});

class BaseHelper {
  var get = GetIt.I;
  FirebaseFirestore store;
  FirebaseAuth auth;
  FirebaseFunctions? functions;
  FirebaseStorage storage;
  String baseURL = 'testnet.mirrornode.hedera.com';
  http.Client client = http.Client();
  BaseHelper(
      {required this.store,
      required this.auth,
      this.functions,
      required this.storage});

  Future<BalanceResponse> retreiveBalance({required String accountID}) async {
    debugPrint('retreiving NFTs for usage with id:$accountID');
    var uri = Uri.https(baseURL, 'api/v1/accounts', {'account.id': accountID});
    var response = await client.get(uri);
    int hbar = jsonDecode(response.body)['accounts'][0]['balance']['balance'];
    List data = jsonDecode(response.body)['accounts'][0]['balance']['tokens'];
    TokensType dym = [];
    for (var item in data) {
      dym.add((balance: item['balance'], tokenId: item['token_id']));
    }
    return (hbar: hbar, tokens: dym);
  }

  Future<List<NftInfo>> getNFTData(List<String> nfts) async {
    List<NftInfo> all = [];

    for (var nft in nfts) {
      var ss = (await store
              .collection('transfers')
              .where('receiptID', isEqualTo: nft)
              .limit(1)
              .get())
          .docs[0]
          .data();
      var txn = Transfer.fromMap(ss);

      var imageLinks = Brand.fromMap((await store
              .collection('brands')
              .where('id', isEqualTo: txn.brandID)
              .limit(1)
              .get())
          .docs[0]
          .data());

      var scanned = ScanModel.fromMap(
          (await store.doc('barcodes/${txn.barcodeID}').get()).data()!);
      var ownership = await GetIt.I<DataBase>().getOwnership(txn.barcodeID);

      all.add((
        imageLinks: imageLinks.catalog
            .firstWhere((element) => element.id == txn.productID)
            .imageLink,
        review: '',
        stars: [4, 3, 5, 6, 7],
        productName: scanned.productName!,
        tranfer: txn,
        ownership: ownership
      ));
      //   // images, leave a review, comments, product name, brand id, date acquired, ownership history
    }
    return all;
  }
}


//**
// {"accounts":
// [{"account":"0.0.14962704",
// "alias":null,
// "auto_renew_period":7776000,
// "balance":{"balance":3000,"timestamp":"1687532395.943822003",
//"tokens":[{"token_id":"0.0.14972043","balance":1}]} */