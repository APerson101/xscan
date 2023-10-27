import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/models/brand_manufacturer.dart';
import 'package:xscan/brand%20view/models/product.dart';
import 'package:xscan/worker/models/scanmodel.dart';

import '../../all/providers/momo_providers.dart';
import '../../brand view/models/brand.dart';
import '../../brand view/models/manufacturer.dart';
import '../../models/Escrow.dart';
import '../models/employee.dart';
import '../models/file.dart';
import '../screens/main_screen_manufacturer.dart';

part 'manu_providers.g.dart';

@riverpod
FutureOr<(Manufacturer, List<BrandManufaturer>, List<Escrow?>)> loadManuInfo(
    LoadManuInfoRef ref, String id) async {
  var db = GetIt.I<DataBase>();
  var manu = await db.loadManuInfo(id);
  var notifications = await db.getPendingAgreements(id: manu.id);
  ref.watch(notificationsNumber.notifier).state = notifications.length;

  var escrows = await ref.watch(getEscrowStatusForIDProvider(id).future);

  return (manu, notifications, escrows);
}

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
@riverpod
FutureOr<Brand> getBrand(GetBrandRef ref, String id) async {
  var db = GetIt.I<DataBase>();
  return await db.getBrandFromId(brandID: id);
}

final deleteStaff = FutureProvider.family<void, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  await db.deleteStaff(id);
});

final getPendingRequestProvider =
    FutureProvider.family<List<ScanModel>, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getPendingApprovalManu(id);
});

/// approve pending

enum ManuApprovePendingEnum { success, failure, loading, idle }

@riverpod
class ManuApprovePending extends _$ManuApprovePending {
  @override
  FutureOr<ManuApprovePendingEnum> build() async {
    return ManuApprovePendingEnum.idle;
  }

  approvePending(ScanModel e, String barcode, Manufacturer business) async {
    state = await AsyncValue.guard(() {
      return Future.delayed(const Duration(seconds: 0), () async {
        var db = GetIt.I<DataBase>();
        await db.approveProductsManu(barcode, business.id);
        var file = FileModelHedera(
          manufacturerApproved: 'true',
          brandApproved: 'false',
          brandName: e.brandName!,
          created: DateTime.now(),
          productName: e.productName!,
          productID: e.productID!,
          barcode: barcode,
          manufacturerName: business.name,
        );
        var pk = await db.getPKfromName(e.brandName!);
        await db.saveUpdateToFile(
            business.privateKey, file.toJson(), file.toMap(), barcode, pk);
        return ManuApprovePendingEnum.success;
      });
    });
  }
}

/// pending requets: waiting for brand to respond

// enum ManuBrandPendingEnum { success, idle, pending, approved }

// @riverpod
// class ManuBrandPending extends _$ManuBrandPending {
//   @override
//   FutureOr<ManuBrandPendingEnum> build() async {
//     return ManuBrandPendingEnum.idle;
//   }

//   approvePending(String barcode, String businessID) async {
//     state = await AsyncValue.guard(() {
//       return Future.delayed(const Duration(seconds: 0), () async {
//         var db = GetIt.I<DataBase>();
//         return (await db.requestsWaitingForBrandResponse(
//           businessID,
//           barcode,
//         ))
//             ? ManuBrandPendingEnum.approved
//             : ManuBrandPendingEnum.pending;
//       });
//     });
//   }
// }
