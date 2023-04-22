import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/models/brand_manufacturer.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../models/brand.dart';
import '../models/manufacturer_summart.dart';
import '../models/transfer.dart';
import '../models/verification.dart';

part 'brand_providers.g.dart';

final getManuSummaryProvider =
    FutureProvider.family<List<ManufacturerSummary>, Brand>((ref, brand) async {
  var db = GetIt.I<DataBase>();
  return await db.getManuSummary(brand.id, brand.name);
});

final getBrandInfoProvider =
    FutureProvider.family<Brand, String>((ref, brandID) async {
  var db = GetIt.I<DataBase>();
  return await db.getBrandFromId(brandID: brandID);
});

final getallManufacturersProvider = FutureProvider((ref) async {
  var db = GetIt.I<DataBase>();
  return await db.getAllManufacturers();
});

enum RemoveProductStateEnum { successful, idle }

@riverpod
class RemoveProductState extends _$RemoveProductState {
  @override
  FutureOr<RemoveProductStateEnum> build() async {
    return RemoveProductStateEnum.idle;
  }

  removeProduct(Brand brand, String productID, String brandID) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      await db.removeProduct(brand, productID, brandID);
      return RemoveProductStateEnum.successful;
    });
  }
}

enum SendManuRequestStateEnum { successful, idle, failed }

@riverpod
class SendManuRequestState extends _$SendManuRequestState {
  @override
  FutureOr<SendManuRequestStateEnum> build() async {
    return SendManuRequestStateEnum.idle;
  }

  sendManufacturerRequest(BrandManufaturer request) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      await db.sendManufacturerRequest(request);
      return SendManuRequestStateEnum.successful;
    });
  }
}

enum RemoveManuRequestStateEnum { successful, idle }

@riverpod
class RemoveManuRequestState extends _$RemoveManuRequestState {
  @override
  FutureOr<RemoveManuRequestStateEnum> build() async {
    return RemoveManuRequestStateEnum.idle;
  }

  withdrawManufacturerRequest(
      String productID, String brandID, String requestID) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      await db.withdrawManufacturerRequest(productID, brandID, requestID);
      return RemoveManuRequestStateEnum.successful;
    });
  }
}

enum ApproveProductStateEnum { successful, idle }

@riverpod
class ApproveProductState extends _$ApproveProductState {
  @override
  FutureOr<ApproveProductStateEnum> build() async {
    return ApproveProductStateEnum.idle;
  }

  withdrawManufacturerRequest(String barcode, String brandID) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      await db.approveProducts(
        barcode,
        brandID,
      );
      return ApproveProductStateEnum.successful;
    });
  }
}

final getPendingApprovalProvider =
    FutureProvider.family<List<ScanModel>, String>((ref, brandID) async {
  var db = GetIt.I<DataBase>();
  return await db.getPendingApproval(brandID);
});

final getVerificationsProvider =
    FutureProvider.family<List<Verification>, String>((ref, brandID) async {
  var db = GetIt.I<DataBase>();
  return await db.getNumberOfVerifications(brandID);
});
final getOwnershipTransferProvider =
    FutureProvider.family<List<Transfer>, String>((ref, brandID) async {
  var db = GetIt.I<DataBase>();
  return await db.getAllOwnership(brandID);
});