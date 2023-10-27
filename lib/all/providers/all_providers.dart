import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';

import '../../amplifyconfiguration.dart';
import '../../models/ModelProvider.dart';

part 'all_providers.g.dart';

@riverpod
FutureOr sendHbarToReceiver(SendHbarToReceiverRef ref, String receiverID,
    String senderAccountID, String senderPK, int amount) async {
  await GetIt.I<DataBase>()
      .sendHbar(receiverID, senderAccountID, senderPK, amount);
}

@riverpod
Future<void> config(ConfigRef ref) async {
  await Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));
  await Amplify.configure(amplifyconfig);
}
