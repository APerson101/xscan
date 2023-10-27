import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

String baseUrl = "https://sandbox.momodeveloper.mtn.com";

createCredentials() async {
  var client = http.Client();
  var subscKey = "fb58dbe16879488fa245c5b756409f2f";
  var id = const Uuid().v4();
  var header = {
    "X-Reference-Id": id,
    'Content-Type': 'application/json',
    'Cache-Control': 'no-cache',
    "Ocp-Apim-Subscription-Key": subscKey,
  };
  var response = await client.post(
      Uri.https("sandbox.momodeveloper.mtn.com", "v1_0/apiuser"),
      headers: header,
      body: jsonEncode({"providerCallbackHost": "string"}));
  print(response.statusCode);
  print(response.reasonPhrase);
  print("CREATED API USER");
  return id;
}

keyCreate(String id) async {
  var client = http.Client();
  var subscKey = "fb58dbe16879488fa245c5b756409f2f";
  var header = {
    'Cache-Control': 'no-cache',
    "Ocp-Apim-Subscription-Key": subscKey,
  };
  var response = await client.post(
      Uri.https("sandbox.momodeveloper.mtn.com", "v1_0/apiuser/$id/apikey"),
      headers: header,
      body: jsonEncode({"providerCallbackHost": "string"}));
  print(response.body);
  return (jsonDecode(response.body)['apiKey']);
}

getKey() async {
  var id = "3b2f1f7a-1450-4982-a633-2968c42684e1";
  var client = http.Client();
  var subscKey = "fb58dbe16879488fa245c5b756409f2f";
  var header = {
    'Cache-Control': 'no-cache',
    "Ocp-Apim-Subscription-Key": subscKey,
  };
  var response = await client.get(
      Uri.https("sandbox.momodeveloper.mtn.com", "v1_0/apiuser/$id"),
      headers: header);
  print(jsonDecode(response.body));
}

Future<String> generateAccessTokenDisburse(String type, String auth) async {
  var client = http.Client();
  var subscKey = "fb58dbe16879488fa245c5b756409f2f";

  var response = await client.post(
      Uri.parse("https://sandbox.momodeveloper.mtn.com/$type/token/"),
      headers: {
        "Authorization": 'Basic $auth',
        "Ocp-Apim-Subscription-Key": subscKey,
      });

  print(response.request?.url);
  print(response.body);
  print(response.statusCode);
  print(response.reasonPhrase);
  return jsonDecode(response.body)["access_token"];
}

main() async {
  print(const Uuid().v4());
  return;
  var id = await createCredentials();
  print(id);
  var apikey = await keyCreate(id);
  print(apikey);
  var authHeader = base64Encode(utf8.encode("$id:$apikey"));
  print(authHeader);

  var jwt = await generateAccessTokenDisburse("collection", authHeader);
  print(jwt);
}
