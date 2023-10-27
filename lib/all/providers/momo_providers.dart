import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import "package:http/http.dart" as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import "package:uuid/uuid.dart";
import 'package:xscan/models/ModelProvider.dart';

part 'momo_providers.g.dart';

const String auth =
    "NTg4ZmE0YjUtMmM0ZS00MDA2LTkzYmQtMjEzYzhlOTU3YWRlOjBiNTRjMGQwYmMxNTQ2MDhiYTdkOGZjZTVmZDFmYjli";
String baseUrl = "https://sandbox.momodeveloper.mtn.com/";
@riverpod
FutureOr<String> requestToPayToEscrow(
    RequestToPayToEscrowRef ref,
    String senderNumber,
    String receiverID,
    String businessID,
    int amount,
    int quantity,
    String businessName,
    String productName,
    String manufacturerName,
    String receiverNumber,
    String productID) async {
  String referenceID = const Uuid().v4();
  var cl = http.Client();
  var access = await (getAccessToken('collection'));
  var subscKey = "fb58dbe16879488fa245c5b756409f2f";
  debugPrint(access);
  var response =
      await cl.post(Uri.parse('${baseUrl}collection/v1_0/requesttopay'),
          headers: {
            "Authorization": "Bearer $access",
            "X-Reference-Id": const Uuid().v4(),
            "X-Target-Environment": "sandbox",
            'Content-Type': 'application/json',
            'Cache-Control': 'no-cache',
            "Ocp-Apim-Subscription-Key": subscKey,
          },
          body: jsonEncode({
            "amount": amount.toString(),
            "currency": "EUR",
            "externalId": referenceID,
            "payer": {
              "partyIdType": "MSISDN",
              "partyId": "56733123453",
              // "partyId": senderNumber,
            },
          }));
  if (response.statusCode == 202) {
    await Amplify.API
        .mutate(
            request: ModelMutations.create(Escrow(
                business: businessID,
                manufacturer: receiverID,
                businessNumber: senderNumber,
                manufacturerNumber: receiverNumber,
                businessName: businessName,
                product: productID,
                quantity: quantity.toString(),
                status: EscrowStatus.awaitingFunds.name,
                referenceid: referenceID,
                amount: amount.toString(),
                notes:
                    "The amount of $amount NGN would be held until $businessName receives $quantity of $productName from $manufacturerName")))
        .response;
    // reduce balance from user
    return referenceID;
  } else {
    throw Error();
  }
}

@riverpod
FutureOr<List<Escrow?>> getEscrowStatusForID(
    GetEscrowStatusForIDRef ref, String id) async {
  var client = GetIt.I<http.Client>();
  var access = await (getAccessToken('collection'));
  var subscKey = "fb58dbe16879488fa245c5b756409f2f";
  var escrowList = await Amplify.API
      .query(
          request: ModelQueries.list(Escrow.classType,
              where: Escrow.BUSINESS.eq(id).or(Escrow.MANUFACTURER.eq(id))))
      .response;
  if (escrowList.data == null) return [];
  for (var es in escrowList.data!.items) {
    var referenceId = es!.referenceid;
    var response = await client.get(
        Uri.parse('${baseUrl}collection/v1_0/requesttopay/$referenceId'),
        headers: {
          "Authorization": "Bearer $access",
          "X-Target-Environment": "sandbox",
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
          "Ocp-Apim-Subscription-Key": subscKey,
        });
    if (response.statusCode == 200) {
      print(response.body);
      var status = jsonDecode(response.body)['status'];
      // update Escrow history
      safePrint(status);
      if (status != "ACCEPTED" && es.status == "awaitingFunds") {
        await Amplify.API
            .mutate(
                request: ModelMutations.update(
                    es.copyWith(status: EscrowStatus.manuAwait.name)))
            .response;
      }
    }
  }

  return (await Amplify.API
          .query(request: ModelQueries.list(Escrow.classType))
          .response)
      .data!
      .items;
}

@riverpod
FutureOr<List<Escrow?>> disburseToBusiness(
    DisburseToBusinessRef ref, String id) async {
  var client = GetIt.I<http.Client>();
  // var cl = http.Client();
  var escrowList = await Amplify.API
      .query(
          request: ModelQueries.list(Escrow.classType,
              where: Escrow.REFERENCEID.eq(id), limit: 1))
      .response;
  var activeEscrow = escrowList.data!.items[0]!;
  String referenceID = const Uuid().v4();
  var authHeader = await generateAccessTokenDisburse('disbursement');
  var response = await client
      .post(Uri.parse('${baseUrl}disbursement/v2_0/deposit'), headers: {
    "Authorization": "Bearer $authHeader",
    "X-Reference-Id": const Uuid().v4(),
    "X-Target-Environment": "sandbox"
  }, body: {
    "amount": activeEscrow.amount,
    "currency": "EUR",
    "externalId": referenceID,
    "payee": {
      "partyIdType": "MSISDN",
      "partyId": activeEscrow.manufacturerNumber
    },
    "payerMessage":
        "You have received ${activeEscrow.amount} from ${activeEscrow.businessName} for producing ${activeEscrow.quantity} of ${activeEscrow.product}",
    "payeeNote": "Receiving Funds for completion of transaction"
  });
  if (response.statusCode == 200) {
    await Amplify.API
        .mutate(
            request: ModelMutations.update(
                activeEscrow.copyWith(status: EscrowStatus.complete.name)))
        .response;
  }
  return (await Amplify.API
          .query(request: ModelQueries.list(Escrow.classType))
          .response)
      .data!
      .items;
}

Future<(String, int)> generateAccessTokenDisburse(String type) async {
  var client = GetIt.I<http.Client>();
  var subscKey = "fb58dbe16879488fa245c5b756409f2f";

  var response = await client.post(
      Uri.parse("https://sandbox.momodeveloper.mtn.com/$type/token/"),
      headers: {
        "Authorization": 'Basic $auth',
        "Ocp-Apim-Subscription-Key": subscKey,
      });

  safePrint(response.request?.url);
  safePrint(response.body);
  safePrint(response.statusCode);
  safePrint(response.reasonPhrase);
  return (
    jsonDecode(response.body)["access_token"] as String,
    jsonDecode(response.body)["expires_in"] as int
  );
}

Future<String> getAccessToken(String type) async {
  var momo = await Amplify.API
      .query(
          request: ModelQueries.get(MomoToken.classType,
              const MomoTokenModelIdentifier(id: "momo_access_id")))
      .response;
  if (momo.data != null) {
    if (DateTime.now().isAfter(DateTime.parse(momo.data!.expires))) {
      // generate new
      var (newToken, expiry) = await generateAccessTokenDisburse(type);
      var newmomo = momo.data!.copyWith(
          auth: newToken,
          expires: DateTime.now().add(Duration(seconds: expiry)).toString());
      await Amplify.API
          .mutate(request: ModelMutations.update(newmomo))
          .response;
      return newToken;
    }

    return momo.data!.auth;
  } else {
    // auth is null, create new
    var (newToken, expiry) = await generateAccessTokenDisburse(type);
    await Amplify.API
        .mutate(
            request: ModelMutations.create(MomoToken(
                id: "momo_access_id",
                auth: newToken.toString(),
                expires:
                    DateTime.now().add(Duration(seconds: expiry)).toString())))
        .response;

    return newToken;
  }
}

enum EscrowStatus { awaitingFunds, manuAwait, businessAwait, complete }
