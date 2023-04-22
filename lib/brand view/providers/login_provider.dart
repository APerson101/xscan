import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/screens/login_view.dart';

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

        // var type = Random.secure().nextInt(LoginStateEnum.values.length);
        // debugPrint(describeEnum(LoginStateEnum.values[type]));
        // return LoginStateEnum.signedIn;
      });
    });
  }

  @override
  FutureOr<LoginStateEnum> build() async {
    print("the user is : ${GetIt.I<FirebaseAuth>().currentUser?.email}");
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

  login(String email, String password) async {
    return _attemptLogin(email, password);
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

enum UserTypesEnum { admin, brand, manufacturer, employee, sales }
