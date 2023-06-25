import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/models/brand_manufacturer.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../../manufacturer/models/quotation.dart';
import '../models/brand.dart';
import '../models/escrow.dart';
import '../models/manufacturer_summart.dart';
import '../models/transfer.dart';
import '../models/verification.dart';
import '../screens/brand_home_view.dart';

part 'brand_providers.g.dart';

final getManuSummaryProvider =
    FutureProvider.family<List<ManufacturerSummary>, Brand>((ref, brand) async {
  var db = GetIt.I<DataBase>();
  return await db.getManuSummary(brand.id, brand.name);
});
@riverpod
FutureOr<(Brand, List<QuotationModel>)> getBrandInfoProvider(
    GetBrandInfoProviderRef ref, String brandID) async {
  var db = GetIt.I<DataBase>();
  var brand = await db.getBrandFromId(brandID: brandID);
  List<QuotationModel> notifications =
      (await db.loadBrandNotifications(id: brandID));
  ref.watch(notLength.notifier).state = notifications.length;

  return (brand, notifications);
}

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

  approveProductFromManu(
      String barcode, Brand brand, String partnershipID) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      await db.approveProducts(barcode, brand.id, partnershipID);
      var fileID = await db.getFileFromBarcode(barcode);
      var file = await db.getFileContentDB(fileID);
      file.brandApproved = 'true';
      await db.appendFileBrand(brand.privateKey, fileID, file.toJson());
      // check to see if this is the last one that needs approval then send all funds to manufacturer
      BrandManufaturer partnership =
          await db.getPartnershipFromID(partnershipID);
      if (partnership.approved == partnership.quantity) {
        // release funds from escrow
        Escrow escrow = await db.getEscrowFromPartnershipID(partnershipID);
        await db.approveEscrow(escrow);
      }
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

final getBusinessNameFromString =
    FutureProvider.family<String, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getBusinessNameFromID(id);
});
