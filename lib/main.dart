import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/helpers/db2.dart';

import 'brand view/providers/login_provider.dart';
import 'brand view/screens/login_view.dart';
import 'brand view/screens/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.useAuthEmulator('172.17.15.187', 9099);
  // await FirebaseStorage.instance.useStorageEmulator('172.17.15.187', 9199);
  // FirebaseFirestore.instance.settings = const Settings(
  //     host: '172.17.15.187:8080', sslEnabled: false, persistenceEnabled: false);
  GetIt.I.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  GetIt.I.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  // GetIt.I.registerSingleton<FirebaseFirestore>(
  //     FirebaseFirestore.instance..useFirestoreEmulator('172.17.15.187', 8080));
  // GetIt.I.registerSingleton<FirebaseFunctions>(
  //     FirebaseFunctions.instance..useFunctionsEmulator('172.17.15.187', 5001));
  GetIt.I.registerSingleton<DataBase>(DataBase(
      auth: GetIt.I<FirebaseAuth>(),
      functions: GetIt.I<FirebaseFunctions>(),
      storage: GetIt.I<FirebaseStorage>(),
      store: GetIt.I<FirebaseFirestore>()));
  GetIt.I.registerSingleton<BaseHelper>(BaseHelper(
      auth: GetIt.I<FirebaseAuth>(),
      functions: GetIt.I<FirebaseFunctions>(),
      storage: GetIt.I<FirebaseStorage>(),
      store: GetIt.I<FirebaseFirestore>()));

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData().copyWith(
    //       textTheme: GoogleFonts.alegreyaSansTextTheme(),
    //     ),
    //     home: const GenerateBarCode());

    var loginState = ref.watch(loginStateProvider);

    Widget view = Container();
    return loginState.when(data: (state) {
      switch (state) {
        case LoginStateEnum.loggedOut:
          view = LoginView();
          break;
        case LoginStateEnum.signedIn:
          view = const MainView();
          break;
      }
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
            textTheme: GoogleFonts.alegreyaSansTextTheme(),
          ),
          home: Scaffold(body: view));
    }, error: (Object error, StackTrace stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return const MaterialApp(
          home: Scaffold(body: Center(child: Text("error loading login"))));
    }, loading: () {
      return Container();
    });
  }
}

final generatefakeData = FutureProvider((ref) async {
  return;
});
