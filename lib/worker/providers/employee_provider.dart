import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/manufacturer/models/employee.dart';

import '../../brand view/helpers/db.dart';
import '../../brand view/models/manufacturer.dart';
import '../models/scanmodel.dart';

part 'employee_provider.g.dart';

enum EmployeeApproveCodeEnum { successful, idle }

@riverpod
class EmployeeApproveCode extends _$EmployeeApproveCode {
  @override
  FutureOr<EmployeeApproveCodeEnum> build() async {
    return EmployeeApproveCodeEnum.idle;
  }

  employeeScanItem(String barcode, ScanModel scanModel) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      var brandName = await db.getBrandNameFromProductID(scanModel.productID!);
      await db.employeeScanItem(
        barcode,
        scanModel..brandName = brandName,
      );
      return EmployeeApproveCodeEnum.successful;
    });
  }
}

final getAllEmployeeProducts =
    FutureProvider.family<List<Agreement>, String>((ref, businessID) async {
  var db = GetIt.I<DataBase>();
  return await db.getProductsEmployeeWorksFor(businessID);
});

final getEmployeeFromID =
    FutureProvider.family<Employee, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getEmployeeFromID(id: id);
});

final getEmpHistoryProvider =
    FutureProvider.family<List<ScanModel>, String>((ref, empID) async {
  var db = GetIt.I<DataBase>();
  return await db.getEmpScanHistory(empID);
});

final getEmpScanStatus =
    FutureProvider.family<bool, String>((ref, barcode) async {
  var db = GetIt.I<DataBase>();
  return await db.getEmpScanStatus(barcode);
});
