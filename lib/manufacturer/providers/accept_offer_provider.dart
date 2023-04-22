import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';

part 'accept_offer_provider.g.dart';

enum AcceptOfferCreationState { success, failure, loading, idle }

@riverpod
class AcceptOffer extends _$AcceptOffer {
  @override
  FutureOr<AcceptOfferCreationState> build() async {
    return AcceptOfferCreationState.idle;
  }

  _attemptCreation(String offerID) async {
    state = const AsyncValue.data(AcceptOfferCreationState.loading);
    try {
      state = await AsyncValue.guard(() {
        return Future.delayed(const Duration(seconds: 0), () async {
          var db = GetIt.I<DataBase>();
          await db.acceptOffer(offerID);
          return AcceptOfferCreationState.success;
        });
      });
    } on FirebaseAuthException {
      return AcceptOfferCreationState.failure;
    }
  }

  acceptOffer(String offerID) async {
    await _attemptCreation(offerID);
  }
}
