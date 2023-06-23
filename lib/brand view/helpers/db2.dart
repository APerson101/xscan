import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

typedef BalanceResponse = ({int hbar, TokensType tokens});
typedef TokensType = List<({String tokenId, int balance})>;

class BaseHelper {
  var get = GetIt.I;
  FirebaseFirestore store;
  FirebaseAuth auth;
  FirebaseFunctions functions;
  FirebaseStorage storage;
  String baseURL = 'testnet.mirrornode.hedera.com';
  http.Client client = http.Client();
  BaseHelper(
      {required this.store,
      required this.auth,
      required this.functions,
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
}


//**
// {"accounts":
// [{"account":"0.0.14962704",
// "alias":null,
// "auto_renew_period":7776000,
// "balance":{"balance":3000,"timestamp":"1687532395.943822003",
//"tokens":[{"token_id":"0.0.14972043","balance":1}]} */