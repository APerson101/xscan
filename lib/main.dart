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
  await FirebaseAuth.instance.useAuthEmulator('172.17.15.187', 9099);
  await FirebaseStorage.instance.useStorageEmulator('172.17.15.187', 9199);
  FirebaseFirestore.instance.settings = const Settings(
      host: '172.17.15.187:8080', sslEnabled: false, persistenceEnabled: false);
  GetIt.I.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  GetIt.I.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  GetIt.I.registerSingleton<FirebaseFirestore>(
      FirebaseFirestore.instance..useFirestoreEmulator('172.17.15.187', 8080));
  GetIt.I.registerSingleton<FirebaseFunctions>(
      FirebaseFunctions.instance..useFunctionsEmulator('172.17.15.187', 5001));
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
  /*
  var db = GetIt.I<DataBase>();
// create brand and account

  var brandID = await db.createFakeUser('b@x.com', '11111111');
  var empID = await db.createFakeUser('e@x.com', '11111111');
  var manuID = await db.createFakeUser('m@x.com', '11111111');
  await db.storeFakeUser(brandID, 'brand');
  await db.storeFakeUser(manuID, 'manufacturer');
  await db.storeFakeUser(empID, 'employee');
  var baccount = await db.createAccount();
  String baccID = baccount['accountID'];
  String bpk = baccount['privateKey'];
  List<Product> brandPrducts = List.generate(
      5,
      (index) => Product(
          name: 'Product $index',
          id: const Uuid().v4().toString(),
          brandOwner: 'JK vison',
          notes: 'sample notes',
          imageLink: [],
          created: DateTime.now()));
  var brand = Brand(
      name: 'JK vison',
      id: brandID,
      privateKey: bpk,
      accountID: baccID,
      location: 'Abuja',
      created: DateTime.now(),
      catalog: brandPrducts);
  await db.createBrand(brand: brand);
// create business and account
  var account = await db.createAccount();
  String accID = account['accountID'];
  String pk = account['privateKey'];
  await db.createManufacturers(
      manu: Manufacturer(
          name: 'manufacturer name',
          location: 'Wuse',
          accountID: accID,
          privateKey: pk,
          notes: 'Notes about this guy',
          id: manuID,
          productions: brandPrducts));

  var employee = Employee(
      email: 'e@x.com',
      password: '11111111',
      name: 'Toechukwu Franklin',
      id: empID,
      businessID: manuID);
  await db.createEmployees(empID, employee);

  // create sales
  var salesID = await db.createFakeUser('s@x.com', '11111111');
  await db.storeFakeUser(salesID, 'sales');
  var saccount = await db.createAccount();
  String saccID = saccount['accountID'];
  String spk = saccount['privateKey'];
  await db.createSales(
      salesID,
      SalesModel(
          id: salesID,
          name: 'Minjirya',
          email: 's@x.com',
          brandID: brandID,
          brandName: 'JK vison',
          privateKey: spk,
          accountID: saccID));

          */
});
