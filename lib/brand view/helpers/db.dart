import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:xscan/brand%20view/models/brand.dart';
import 'package:xscan/brand%20view/models/brand_manufacturer.dart';
import 'package:xscan/brand%20view/models/manufacturer.dart';
import 'package:xscan/brand%20view/models/product.dart';
import 'package:xscan/brand%20view/models/transfer.dart';
import 'package:xscan/brand%20view/models/verification.dart';
import 'package:xscan/brand%20view/providers/login_provider.dart';
import 'package:xscan/manufacturer/models/employee.dart';
import 'package:xscan/manufacturer/models/file.dart';
import 'package:xscan/sales/models/sales_model.dart';

import '../../sales/models/transfermode.dart';
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

  Future getPKFromID(String brandID) async {
    return (await store
            .collection('brands')
            .where('id', isEqualTo: brandID)
            .limit(1)
            .get())
        .docs[0]
        .get('privateKey');
  }

  saveUpdateToFile(String manufacturerPK, String textTobeStored,
      dynamic jsonFormat, String barcode, String brandPK) async {
    String fileID = (await functions.httpsCallable('storeBarcodeInFile').call({
      'data': {'pk': brandPK, 'text': '$textTobeStored --- '}
    }))
        .data;

    debugPrint('created file id is: $fileID');

    // save things to the database
    (await store
        .doc('files/$fileID')
        .set({'fileID': fileID, 'barcode': barcode}));
    (await store.collection('files/$fileID/updates').add(jsonFormat));
    return fileID;
  }

  Future<FileModelHedera> getFileContentDB(String fileID) async {
    var dy = (await store.collection('files/$fileID/updates').limit(1).get())
        .docs[0]
        .data();
    return FileModelHedera.fromMap(dy);
  }

  getFileContent(String fileID) async {
    String content = (await functions.httpsCallable('getFileContent').call({
      'data': {'fileId': fileID}
    }))
        .data;

    debugPrint('file content is: $content');
  }

  getFileFromBarcode(String barcode) async {
    return (await store
            .collection('files')
            .where('barcode', isEqualTo: barcode)
            .limit(1)
            .get())
        .docs[0]
        .id;
  }

  appendFileBrand(
    String brandPK,
    String fileID,
    String textTobeStored,
  ) async {
    await functions.httpsCallable('appendFile').call({
      'data': {'fileId': fileID, 'text': '$textTobeStored --- ', 'pk': brandPK}
    });
    debugPrint('file appent success');

    var id = (await store.collection('files/$fileID/updates').limit(1).get())
        .docs[0]
        .id;

    (await store
        .doc('files/$fileID/updates/$id')
        .update({'brandApproved': 'true'}));
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
            .where('scanner.businessID', isEqualTo: id)
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
            .where('scanner.businessID', isEqualTo: id)
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

  acceptOffer(String offerID, Product product, String manufacturerID) async {
    await store
        .doc('partnerships/$offerID')
        .update({'manufacturerAgreed': true});

    var id = (await store
            .collection('manufacturers')
            .where('id', isEqualTo: manufacturerID)
            .limit(1)
            .get())
        .docs[0]
        .id;
    (await store.doc('manufacturers/$id').update({
      'productions': FieldValue.arrayUnion([product.toMap()])
    }));

    // add product to manufacturer
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
    await store.doc('partnerships/${request.id}').set(request.toMap());
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

  Future<List<ScanModel>> getPendingApproval(String brandName) async {
    var allScanned = await getAllScannedBarcode();
    var particularBrand =
        allScanned.where((element) => element.brandName == brandName).toList();

    var ss = <ScanModel>[];
    for (var scanned in particularBrand) {
      var history = await getBarcodescanhistory(scanned.barcode!);
      if (history.length == 1) {
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
      var brand = mapped.catalog.where((element) => element.id == productID);
      if (brand.isNotEmpty) {
        return mapped.name;
      }
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
    return all;
  }

  getEmpScanStatus(String barcode) async {
    var updates = await getBarcodescanhistory(barcode);
    return updates.isEmpty ? false : true;
  }

  Future<List<ScanModel>> getPendingApprovalManu(String businessID) async {
    var allScanned = await getAllScannedBarcode();
    var ss = <ScanModel>[];
    var businessScanned = allScanned
        .where((element) => element.scanner!.businessID == businessID)
        .toList();

    for (var bu in businessScanned) {
      var history = await getBarcodescanhistory(bu.barcode!);
      if (history.isEmpty) {
        // unapproved
        ss.add(bu);
      }
    }
    return ss;
  }

  approveProductsManu(String barcode, String businessID) async {
    await store.collection('barcodes/$barcode/updates').add(ScanModel(
            barcode: barcode,
            timeAdded: DateTime.now(),
            scanner: Employee(
                email: 'APPROVAL',
                password: 'APPROVAL',
                name: 'BUSINESS APPROVAL',
                id: 'id',
                businessID: businessID))
        .toMap());
  }

  Future<bool> requestsWaitingForBrandResponse(
      String businessID, String barcode) async {
    var history = await getBarcodescanhistory(barcode);
    if (history.length <= 1) {
      // unapproved
      return false;
    }
    return true;
  }

  Future<String> getBusinessNameFromID(String id) async {
    var doc = (await store
            .collection('manufacturers')
            .where('id', isEqualTo: id)
            .limit(1)
            .get())
        .docs[0];
    return doc.get('name');
  }

  Future<SalesModel> getSalesFromID(String id) async {
    var data = (await store
            .collection('sales')
            .where('id', isEqualTo: id)
            .limit(1)
            .get())
        .docs[0]
        .data();
    return SalesModel.fromMap(data);
  }

  getBarcodeInfo({required String code}) async {
    var data = (await store.doc('barcodes/$code').get()).data();
    return ScanModel.fromMap(data!);
  }

  appendFileSales(String barcode, SalesModel staff, fileID, String to,
      String brandPK) async {
    //
    var txn = TransferModel(from: staff.accountID, to: to);
    await functions.httpsCallable('appendFile').call({
      'data': {'fileId': fileID, 'text': '${txn.toJson()} --- ', 'pk': brandPK}
    });
    debugPrint('file appent success');
  }

  getPKfromName(String name) async {
    return (await store
            .collection('brands')
            .where('name', isEqualTo: name)
            .limit(1)
            .get())
        .docs[0]
        .get('privateKey');
  }

  createSales(String id, SalesModel salesman) async {
    (await store.doc('sales/$id').set(salesman.toMap()));
  }

  getAddressFromID(String id) async {
    return (await store
            .collection('brands')
            .where('id', isEqualTo: id)
            .limit(1)
            .get())
        .docs[0]
        .get('accountID');
  }

  saveTransfer(Transfer transfer) async {
    (await store.collection('transfers').add(transfer.toMap()));
  }
}

  // maybe: Retrieve NFT

