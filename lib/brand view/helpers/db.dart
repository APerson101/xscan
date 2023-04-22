import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/models/brand_manufacturer.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/brand%20view/models/product.dart';
import 'package:xscan/brand%20view/models/transfer.dart';
import 'package:xscan/brand%20view/models/verification.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';
import 'package:xscan/manufacturer/models/employee.dart';

import '../../worker/models/scanmodel.dart';
import '../models/manufacturer_summart.dart';

class DataBase {
  var get = GetIt.I;
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;

  getNumberOfVerifications(String brandID) async {
    var docs = (await store
            .collection('verifications')
            .where('brandID', isEqualTo: brandID)
            .get())
        .docs;
    List<Verification> all = [];
    for (var item in docs) {
      all.add(Verification.fromMap(item.data()));
    }
    return all;
  }

  Future<Brand> loadBrandInfo(String brandID) async {
    var data = (await store
            .collection('brands')
            .where('id', isEqualTo: brandID)
            .limit(1)
            .get())
        .docs[0];
    debugPrint("Loaded brand data successfully: ${data.data()}");
    return Brand.fromMap(data.data());
  }

  Future<Manufacturer> loadManuInfo(String id) async {
    var data = (await store
            .collection('manufacturers')
            .where('id', isEqualTo: id)
            .limit(1)
            .get())
        .docs[0];
    debugPrint("Loaded manufacturer data successfully: ${data.data()}");
    return Manufacturer.fromMap(data.data());
  }

  Future<UserTypesEnum> determineUser({required String id}) async {
    var user = await store
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();
    var userDoc = user.docs[0];
    return UserTypesEnum.values
        .firstWhere((element) => describeEnum(element) == userDoc.get('type'));
  }

  String BRAND_ID = '';
  String MANU_ID_1 = '';
  String MANU_ID_2 = '';
  String EMP_1 = '';
  String EMP_2 = '';
  String EMP_3 = '';
  createFakeUser(String email, String password) async {
    var id1 = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return id1.user!.uid;
  }

  storeFakeUser(String id, String type) async {
    await store.collection('users').add({'id': id, 'type': type});
  }

  createUser() async {
    //brand
    var id1 = await auth.createUserWithEmailAndPassword(
        email: '1@1.co', password: '11111111');
    BRAND_ID = id1.user!.uid;
    //manufacturer
    var id2 = await auth.createUserWithEmailAndPassword(
        email: '2@1.co', password: '11111111');
    MANU_ID_1 = id2.user!.uid;

    //manufacturer
    var id3 = await auth.createUserWithEmailAndPassword(
        email: '3@1.co', password: '11111111');
    MANU_ID_2 = id3.user!.uid;
    //Employee
    var id4 = await auth.createUserWithEmailAndPassword(
        email: 'm1@1.co', password: '11111111');
    EMP_1 = id4.user!.uid;
    //Employee
    var id5 = await auth.createUserWithEmailAndPassword(
        email: 'm2@1.co', password: '11111111');
    EMP_2 = id5.user!.uid;

    //Employee
    var id6 = await auth.createUserWithEmailAndPassword(
        email: 'b@1.co', password: '11111111');
    EMP_3 = id6.user!.uid;

    await store.collection('users').add({'id': id1.user!.uid, 'type': 'brand'});
    await store
        .collection('users')
        .add({'id': id2.user!.uid, 'type': 'manufacturer'});
    await store
        .collection('users')
        .add({'id': id3.user!.uid, 'type': 'manufacturer'});
    await store
        .collection('users')
        .add({'id': id4.user!.uid, 'type': 'employee'});
    await store
        .collection('users')
        .add({'id': id5.user!.uid, 'type': 'employee'});
    await store
        .collection('users')
        .add({'id': id6.user!.uid, 'type': 'employee'});
  }

  createBrand({brand}) async {
    await store.collection('brands').add(brand.toMap());
  }

  createManufacturers({Manufacturer? manu}) async {
    await store.collection('manufacturers').add(manu!.toMap());
  }

  createPartnerships() async {
    var uuid = const Uuid();
    var uniqueID = uuid.v4().toString();
    var uniqueID1 = uuid.v4().toString();
    var uniqueID2 = uuid.v4().toString();
    var uniqueID3 = uuid.v4().toString();
    await store.doc('partnerships/$uniqueID').set(BrandManufaturer(
            brandID: BRAND_ID,
            manufacturerID: MANU_ID_1,
            productID: 'id 0',
            quantity: 40,
            userCreated: true,
            id: uniqueID,
            manufacturerAgreed: true,
            dateCreated: DateTime.now())
        .toMap());
    await store.doc('partnerships/$uniqueID1').set(BrandManufaturer(
            brandID: BRAND_ID,
            manufacturerID: MANU_ID_1,
            productID: 'id 1',
            quantity: 40,
            userCreated: true,
            id: uniqueID1,
            manufacturerAgreed: true,
            dateCreated: DateTime.now())
        .toMap());
    await store.doc('partnerships/$uniqueID2').set(BrandManufaturer(
            brandID: BRAND_ID,
            manufacturerID: MANU_ID_1,
            productID: 'id 2',
            quantity: 40,
            userCreated: true,
            id: uniqueID2,
            manufacturerAgreed: true,
            dateCreated: DateTime.now())
        .toMap());
    await store.doc('partnerships/$uniqueID3').set(BrandManufaturer(
            brandID: BRAND_ID,
            manufacturerID: MANU_ID_2,
            productID: 'id 3',
            quantity: 40,
            id: uniqueID3,
            userCreated: true,
            manufacturerAgreed: false,
            dateCreated: DateTime.now())
        .toMap());
  }

  createEmployees(String id, Employee emp) async {
    await store.doc('employees/$id').set(emp.toMap());
  }

  addScannedItem(String scannedItem) async {
    var scanned = await getAllScannedBarcode();
    var index = scanned.indexWhere((element) => element.barcode == scannedItem);
    var scannedModel = ScanModel()
      ..barcode = scannedItem
      ..brandName = 'brand name'
      ..id = '43'
      ..productID = 'id 1'
      ..productName = 'trousers 1'
      ..timeAdded = DateTime.now()
      ..scanner = Employee(
          email: '1.1@co',
          password: '11111111',
          name: 'Toechukwu Kennedy',
          id: EMP_1,
          businessID: 'manufacturer 1');
    if (index == -1) {
      //doesnt exist, create and add
      await store.doc('barcodes/$scannedItem').set(scannedModel.toMap());
    } else {
      // it exists, append
      var cur = scanned[index];
      var id = (await store
              .collection('barcodes')
              .where('barcode', isEqualTo: cur.barcode)
              .get())
          .docs[0]
          .id;
      await store.collection('barcodes/$id/updates').add(scannedModel.toMap());
    }
  }

  Future<List<ScanModel>> getAllScannedBarcode() async {
    var data = await store.collection('barcodes').get();
    if (data.docs.isEmpty) {
      return [];
    } else {
      var allScannedItems = <ScanModel>[];
      for (var doc in data.docs) {
        var docData = doc.data();
        allScannedItems.add(ScanModel.fromMap(docData));
      }
      return allScannedItems;
    }
  }

  Future<List<ScanModel>> getBarcodescanhistory(String barcodeID) async {
    var docs =
        (await store.collection('barcodes/$barcodeID/updates').get()).docs;
    List<ScanModel> all = [];
    for (var doc in docs) {
      all.add(ScanModel.fromMap(doc.data()));
    }
    return all;
  }

  saveUpdateToFile(String manufacturerPK, String textTobeStored) async {
    String fileID = (await functions.httpsCallable('storeBarcodeInFile').call({
      'data': {'pk': manufacturerPK, 'text': textTobeStored}
    }))
        .data;

    debugPrint('created file id is: $fileID');
    return fileID;
  }

  getFileContent(String fileID) async {
    String content = (await functions.httpsCallable('getFileContent').call({
      'data': {'fileId': fileID}
    }))
        .data;

    debugPrint('file content is: $content');
  }

  appendFile(
      String manufacturerPK, String fileID, String textTobeStored) async {
    await functions.httpsCallable('appendFile').call({
      'data': {'fileId': fileID, 'text': textTobeStored, 'pk': manufacturerPK}
    });
    debugPrint('file appent success');
  }

  createNFTReceipt(
      String brandName, String brandSymbol, String receiver) async {
    var nftId = (await functions.httpsCallable('createNFTReceipt').call({
      'data': {
        'brandName': brandName,
        'brandSymbol': brandSymbol,
        'receiver': receiver
      }
    }))
        .data;
    debugPrint('nft created id is: $nftId');
    return nftId;
  }

  transferNFTOwnership(String nftId, String sender, String receiver,
      String senderPrivateKey) async {
    bool data =
        (await functions.httpsCallable('transferItemNftOwnership').call({
      'data': {
        'nftId': nftId,
        'sender': sender,
        'receiver': receiver,
        'senderPrivateKey': senderPrivateKey
      }
    }))
            .data;
    debugPrint('nft ownership transfer status: $data');
  }

  Future<Map<String, dynamic>> createAccount() async {
    var data = (await functions.httpsCallable('createAccount').call({})).data;
    debugPrint('newly created account details is: $data');
    return data;
  }

  Future<List<Employee>> getEmployees({required String manufacturerID}) async {
    var employeesData = (await store
            .collection('employees')
            .where('businessID', isEqualTo: manufacturerID)
            .get())
        .docs;
    List<Employee> employees = [];
    for (var element in employeesData) {
      employees.add(Employee.fromMap(element.data()));
    }
    return employees;
  }

  Future<int> getTodayProductions({required String id}) async {
    var docs = (await store
            .collection('barcodes')
            .where('employee.businessID', isEqualTo: id)
            .where('timeAdded',
                isGreaterThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
            .get())
        .docs
        .length;
    return docs;
  }

  Future<List<ScanModel>> getScannedItems({required String id}) async {
    var docs = (await store
            .collection('barcodes')
            .where('employee.businessID', isEqualTo: id)
            .get())
        .docs;

    List<ScanModel> all = [];
    for (var scanned in docs) {
      all.add(ScanModel.fromMap(scanned.data()));
    }
    return all;
  }

  createEmployee({required Employee employee}) async {
    await store
        .collection('users')
        .add({'id': employee.id, 'type': 'employee'});
    await store.doc('employees/${employee.id}').set(employee.toMap());
  }

  getPendingAgreements({required String id}) async {
    var docs = (await store
            .collection('partnerships')
            .where('manufacturerID', isEqualTo: id)
            .where('manufacturerAgreed', isEqualTo: false)
            .get())
        .docs;
    List<BrandManufaturer> pendingPartnerships = [];
    for (var doc in docs) {
      pendingPartnerships.add(BrandManufaturer.fromMap(doc.data()));
    }
    return pendingPartnerships;
  }

  Future<Product?> getProductFromId({required String productID}) async {
    var allBrands = await store.collection('brands').get();
    var data = allBrands.docs;
    for (var item in data) {
      var catalog = Brand.fromMap(item.data()).catalog;
      var result = catalog.firstWhere((element) => element.id == productID);
      return result;
    }
    return null;
  }

  Future<Brand> getBrandFromId({required String brandID}) async {
    var brand = await store
        .collection('brands')
        .where('id', isEqualTo: brandID)
        .limit(1)
        .get();
    var data = brand.docs[0];
    return Brand.fromMap(data.data());
  }

  acceptOffer(String offerID) async {
    await store
        .doc('partnerships/$offerID')
        .update({'manufacturerAgreed': true});
  }

  deleteStaff(String id) async {
    await store.doc('employees/$id').delete();
    await functions.httpsCallable('deleteuser').call({'data': id});
  }

  addProduct(Product newProduct, String brandID) async {
    var doc = (await store
            .collection('brands')
            .where('id', isEqualTo: brandID)
            .limit(1)
            .get())
        .docs[0];
    var id = doc.id;
    (await store.doc('brands/$id').update({'catalog': newProduct.toMap()}));
  }

  removeProduct(Brand brand, String productID, String brandID) async {
    var copy = brand.catalog;
    copy.removeWhere((element) => element.id == brandID);
    var id = (await store
            .collection('brands')
            .where('id', isEqualTo: brandID)
            .limit(1)
            .get())
        .docs[0]
        .id;
    (await store.doc('brands/$id').set(brand.copyWith(catalog: copy).toMap()));
  }

  sendManufacturerRequest(BrandManufaturer request) async {
    var uuid = const Uuid();
    var uniqueID = uuid.v4().toString();
    await store.doc('partnerships/$uniqueID').set(request.toMap());
  }

  withdrawManufacturerRequest(
      String productID, String brandID, String requestID) async {
    var id = (await store
            .collection('partnerships')
            .where('id', isEqualTo: requestID)
            .limit(1)
            .get())
        .docs[0];
    (await store.doc('partnerships/$id').delete());
  }

  Future<List<Manufacturer>> getAllManufacturers() async {
    var docs = (await store.collection('manufacturers').get()).docs;
    List<Manufacturer> all = [];
    for (var manu in docs) {
      all.add(Manufacturer.fromMap(manu.data()));
    }
    return all;
  }

  Future<List<ManufacturerSummary>> getManuSummary(
      String brandID, String brandName) async {
    // get all manufacturers that has an agreed partnership with this brand
    // for each of them, get the number of things they product for brandName
    var mans = await getAllManufacturers();
    List<Manufacturer> existingPartnerships = [];
    List<int> numberOfProductsBeingHandled = [];
    List<int> numberOfItemsProducedForBrand = [];
    for (var man in mans) {
      var items = man.productions
          .where((element) => element.brandOwner == brandName)
          .toList();
      if (items.isNotEmpty) {
        existingPartnerships.add(man);
        numberOfProductsBeingHandled.add(items.length);
      }
    }
    for (var business in existingPartnerships) {
      numberOfItemsProducedForBrand
          .add((await getScannedItems(id: business.id)).length);
    }
    return List.generate(
        existingPartnerships.length,
        (index) => ManufacturerSummary(
            manufacturedProducts:
                numberOfProductsBeingHandled[index].toString(),
            manufacturerLocation: existingPartnerships[index].location,
            manufacturerName: existingPartnerships[index].name,
            numberItemsProduced:
                numberOfItemsProducedForBrand[index].toString()));
  }

  Future<List<ScanModel>> getPendingApproval(String brandID) async {
    var allScanned = await getAllScannedBarcode();
    var ss = <ScanModel>[];
    for (var scanned in allScanned) {
      var history = await getBarcodescanhistory(scanned.barcode!);
      var verified =
          history.where((element) => element.scanner!.name == brandID).toList();
      if (verified.isEmpty && history.length >= 2) {
        // unapproved
        ss.add(scanned);
      }
    }
    return ss;
  }

  approveProducts(String barcode, String brandID) async {
    await store.collection('barcodes/$barcode/updates').add(ScanModel(
            barcode: barcode,
            scanner: Employee(
                email: 'APPROVAL',
                password: 'APPROVAL',
                name: brandID,
                id: 'id',
                businessID: brandID))
        .toMap());
  }

  getOwnership(String barcode) async {
    // get ownership of NFT
  }

  getAllOwnership(String brandID) async {
    var docs = (await store
            .collection('transfers')
            .where('brandID', isEqualTo: brandID)
            .get())
        .docs;
    List<Transfer> all = [];
    for (var doc in docs) {
      all.add(Transfer.fromMap(doc.data()));
    }
    return all;
  }

  employeeScanItem(String scannedItem, ScanModel scannedModel) async {
    var scanned = await getAllScannedBarcode();
    var index = scanned.indexWhere((element) => element.barcode == scannedItem);

    if (index == -1) {
      //doesnt exist, create and add
      await store.doc('barcodes/$scannedItem').set(scannedModel.toMap());
    } else {
      // it exists, append
      var cur = scanned[index];
      var id = (await store
              .collection('barcodes')
              .where('barcode', isEqualTo: cur.barcode)
              .get())
          .docs[0]
          .id;
      await store.collection('barcodes/$id/updates').add(scannedModel.toMap());
    }
  }

  Future<List<Product>> getProductsEmployeeWorksFor(String businessID) async {
    var doc = (await store
            .collection('manufacturers')
            .where('id', isEqualTo: businessID)
            .limit(1)
            .get())
        .docs[0];
    var data = Manufacturer.fromMap(doc.data());
    return data.productions;
  }

  Future<String> getBrandNameFromProductID(String productID) async {
    var docs = (await store.collection('brands').get()).docs;
    for (var doc in docs) {
      var mapped = Brand.fromMap(doc.data());
      var brand =
          mapped.catalog.firstWhere((element) => element.id == productID);
      return brand.name;
    }
    return '';
  }

  getEmployeeFromID({required String id}) async {
    var emp = (await store
            .collection('employees')
            .where('id', isEqualTo: id)
            .limit(1)
            .get())
        .docs[0];
    return Employee.fromMap(emp.data());
  }

  Future<List<ScanModel>> getEmpScanHistory(String empID) async {
    var docs = (await store
            .collection('barcodes')
            .where('scanner.id', isEqualTo: empID)
            .get())
        .docs;
    List<ScanModel> all = [];
    for (var item in docs) {
      all.add(ScanModel.fromMap(item.data()));
    }
    print(all.length);
    return all;
  }

  getEmpScanStatus(String barcode) async {
    var updates = await getBarcodescanhistory(barcode);
    return updates.isEmpty ? false : true;
  }
}

  // maybe: Retrieve NFT

