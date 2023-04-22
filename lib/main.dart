import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/models/product.dart';
import 'package:xscan/sales/models/sales_model.dart';

import 'brand view/models/manufacturer.dart';
import 'brand view/providers/login_provider.dart';
import 'brand view/screens/login_view.dart';
import 'brand view/screens/main_screen.dart';
import 'firebase_options.dart';
import 'manufacturer/models/employee.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetIt.I.registerSingleton<DataBase>(DataBase());
  // FirebaseFirestore.instance.settings = const Settings(
  //     host: '192.168.8.100:8080', sslEnabled: false, persistenceEnabled: false);
  GetIt.I.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  GetIt.I.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  GetIt.I.registerSingleton<FirebaseFunctions>(FirebaseFunctions.instance);
  // GetIt.I.registerSingleton<FirebaseAuth>(
  //     FirebaseAuth.instance..useAuthEmulator('192.168.8.100', 9099));
  // GetIt.I.registerSingleton<FirebaseFirestore>(
  //     FirebaseFirestore.instance..useFirestoreEmulator('192.168.8.100', 8080));
  // GetIt.I.registerSingleton<FirebaseFunctions>(
  //     FirebaseFunctions.instance..useFunctionsEmulator('192.168.8.100', 5001));

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
    return ref.watch(generatefakeData).when(
        data: (_) {
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
                home: view);
            // home: view);
          }, error: (Object error, StackTrace stackTrace) {
            return const Center(child: Text("error loading login"));
          }, loading: () {
            return Container();
          });
        },
        error: (er, st) => const MaterialApp(
            home: Center(child: Text("Failed to do the thing"))),
        loading: () => const Material(
                child: Center(
              child: CircularProgressIndicator.adaptive(),
            )));
  }
}

final generatefakeData = FutureProvider((ref) async {
  return;
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
});
