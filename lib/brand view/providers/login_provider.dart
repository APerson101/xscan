import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/screens/login_view.dart';
import 'package:xscan/models/Account.dart';
import 'package:xscan/models/ModelProvider.dart';

part 'login_provider.g.dart';

enum LoginStateEnum {
  signedIn,
  loggedOut,
}

@riverpod
class LoginState extends _$LoginState {
  _attemptLogin(String email, String password) async {
    state = await AsyncValue.guard(() {
      return Future.delayed(const Duration(seconds: 0), () async {
        try {
          var user = await GetIt.I<FirebaseAuth>()
              .signInWithEmailAndPassword(email: email, password: password);
          // get type of user
          var userType =
              await GetIt.I<DataBase>().determineUser(id: user.user!.uid);
          ref.watch(userTypeProvider.notifier).state = userType;
          return LoginStateEnum.signedIn;
        } on FirebaseAuthException {
          ref.watch(loginMessage.notifier).state = 'Invalid Details';
          return LoginStateEnum.loggedOut;
        }
      });
    });
  }

  @override
  FutureOr<LoginStateEnum> build() async {
    debugPrint("the user is : ${GetIt.I<FirebaseAuth>().currentUser?.email}");
    // await FirebaseAuth.instance.signOut();

    if (GetIt.I<FirebaseAuth>().currentUser == null) {
      return LoginStateEnum.loggedOut;
    } else {
      // get type of user
      var userType = await GetIt.I<DataBase>()
          .determineUser(id: GetIt.I<FirebaseAuth>().currentUser!.uid);
      ref.watch(userTypeProvider.notifier).state = userType;
      return LoginStateEnum.signedIn;
    }
  }

  Future<void> createFakeData() async {
    var db = GetIt.I<DataBase>();
  }

  login(String email, String password) async {
    return _attemptLogin(email, password);
  }

  createAccount(
      String email, String password, var model, UserTypes type) async {
    ref.watch(signUpState.notifier).state = SignUpStates.creating;
    try {
      var db = GetIt.I<DataBase>();
      var id = await db.createUser(email: email, password: password);
      await db.storeUser(id, type.label);
      if (type == UserTypes.business) {
        await db.createBrand(
            brand: model
              ..id = id
              ..privateKey = "privateKey"
              ..accountID = "accountID");

        // store brand to aws amplify
        await Amplify.API
            .mutate(
                request: ModelMutations.create(Account(
                    id: id,
                    name: model.name,
                    type: 'brand',
                    locaiton: model.location)))
            .response;
      } else if (type == UserTypes.manufacturer) {
        await db.createManufacturers(
            manu: model
              ..id = id
              ..privateKey = "privateKey"
              ..accountID = "accountID");
        // store brand to aws amplify
        await Amplify.API
            .mutate(
                request: ModelMutations.create(Account(
                    id: id,
                    name: model.name,
                    type: 'manufacturer',
                    locaiton: model.location)))
            .response;
      } else if (type == UserTypes.user) {
        await db.createAppUser(
            user: model
              ..id = id
              ..privateKey = "privateKey"
              ..accountID = "accountID");
        // store brand to aws amplify
        await Amplify.API
            .mutate(
                request: ModelMutations.create(Account(
                    id: id,
                    name: "employeee 1",
                    type: 'employee',
                    locaiton: "test location")))
            .response;
      }
      ref.watch(signUpState.notifier).state = SignUpStates.success;
    } catch (e) {
      ref.watch(signUpState.notifier).state = SignUpStates.failure;
    }
  }

  logout() async {
    state = await AsyncValue.guard(() {
      return Future.delayed(const Duration(seconds: 0), () async {
        await GetIt.I<FirebaseAuth>().signOut();
        return LoginStateEnum.loggedOut;
      });
    });
  }
}

final userTypeProvider = StateProvider<UserTypesEnum?>((ref) => null);

enum UserTypesEnum { admin, brand, manufacturer, employee, sales, user }
