import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';

import '../../brand view/helpers/db2.dart';
import '../cross_widgets.dart';

part 'all_providers.g.dart';

@riverpod
FutureOr<BalanceResponse> getHbarBalance(
    GetHbarBalanceRef ref, String accountID) async {
  var value = await GetIt.I<BaseHelper>().retreiveBalance(accountID: accountID);
  ref.watch(balanceProvider.notifier).state = value.hbar;
  return value;
}

@riverpod
FutureOr sendHbarToReceiver(SendHbarToReceiverRef ref, String receiverID,
    String senderAccountID, String senderPK, int amount) async {
  await GetIt.I<DataBase>()
      .sendHbar(receiverID, senderAccountID, senderPK, amount);
}
