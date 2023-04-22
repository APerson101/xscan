import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';

import '../models/employee.dart';

part 'new_location_provider.g.dart';

enum NewEmployeeCreationState { success, failure, loading, idle }

@riverpod
class NewEmployee extends _$NewEmployee {
  @override
  FutureOr<NewEmployeeCreationState> build() async {
    return NewEmployeeCreationState.idle;
  }

  _attemptCreation(Employee employee, String manuId) async {
    state = const AsyncValue.data(NewEmployeeCreationState.loading);
    try {
      state = await AsyncValue.guard(() {
        return Future.delayed(const Duration(seconds: 0), () async {
          var user = await GetIt.I<FirebaseAuth>()
              .createUserWithEmailAndPassword(
                  email: employee.email, password: employee.password);
          var id = user.user!.uid;
          var db = GetIt.I<DataBase>();
          await db.createEmployee(
              employee: employee
                ..id = id
                ..businessID = manuId);
          return NewEmployeeCreationState.success;
        });
      });
    } on FirebaseAuthException {
      return NewEmployeeCreationState.failure;
    }
  }

  attemptCreation(Employee employee, manuId) async {
    await _attemptCreation(employee, manuId);
  }
}
