import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/models/brand_manufacturer.dart';
import 'package:xscan/brand%20view/models/product.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../../brand view/models/brand.dart';
import '../../brand view/models/manufacturer.dart';
import '../models/employee.dart';

final loadManuInfoProvider =
    FutureProvider.family<Manufacturer, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.loadManuInfo(id);
});

final getEmployees =
    FutureProvider.family<List<Employee>, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  var employees = await db.getEmployees(manufacturerID: id);
  return employees;
});

final getThingsProducedToday =
    FutureProvider.family<int, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getTodayProductions(id: id);
});

final getAllScannedItems =
    FutureProvider.family<List<ScanModel>, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getScannedItems(id: id);
});

final getPendingRequests = FutureProvider.family
    .autoDispose<List<BrandManufaturer>, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getPendingAgreements(id: id);
});

final getProduct = FutureProvider.family<Product?, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getProductFromId(productID: id);
});
final getBrand = FutureProvider.family<Brand, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getBrandFromId(brandID: id);
});

final deleteStaff = FutureProvider.family<void, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  await db.deleteStaff(id);
});

final getPendingRequestProvider =
    FutureProvider.family<List<ScanModel>, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
});
