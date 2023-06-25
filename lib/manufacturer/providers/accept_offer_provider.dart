import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/manufacturer/models/quotation.dart';

import '../../brand view/models/brand_manufacturer.dart';
import '../screens/manu_notifications.dart';
import 'manu_providers.dart';

part 'accept_offer_provider.g.dart';

enum AcceptOfferCreationState { success, failure, loading, idle }

@riverpod
class AcceptOffer extends _$AcceptOffer {
  @override
  FutureOr<AcceptOfferCreationState> build() async {
    return AcceptOfferCreationState.idle;
  }

  _attemptCreation(
      String offerID, Agreement agreement, String manufacturerID) async {
    state = const AsyncValue.data(AcceptOfferCreationState.loading);
    try {
      state = await AsyncValue.guard(() {
        return Future.delayed(const Duration(seconds: 0), () async {
          var db = GetIt.I<DataBase>();
          await db.acceptOffer(offerID, agreement, manufacturerID);
          return AcceptOfferCreationState.success;
        });
      });
    } on FirebaseAuthException {
      return AcceptOfferCreationState.failure;
    }
  }

  acceptOffer(
      String offerID, Agreement agreement, String manufacturerID) async {
    await _attemptCreation(offerID, agreement, manufacturerID);
  }
}

@riverpod
class SendQuotation extends _$SendQuotation {
  @override
  FutureOr<int> build(int amount, String brandID, Manufacturer manufacturer,
      BrandManufaturer transaction) async {
    var db = GetIt.I<DataBase>();
    (await db.sendQuotation(QuotationModel(
        amount: amount,
        brandID: brandID,
        transaction: transaction,
        brandAgreed: false,
        id: const Uuid().v4(),
        manu: manufacturer)));
    ref.watch(quotationSentProvider.notifier).state = 1;
    ref.invalidate(loadManuInfoProvider);
    return 1;
  }
}
