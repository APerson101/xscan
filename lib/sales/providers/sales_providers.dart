import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../brand view/helpers/db.dart';
import '../../brand view/models/transfer.dart';
import '../../worker/models/scanmodel.dart';
import '../models/sales_model.dart';

part 'sales_providers.g.dart';

final getSalesInfoProvider =
    FutureProvider.family<SalesModel, String>((ref, id) async {
  var db = GetIt.I<DataBase>();
  return await db.getSalesFromID(id);
});

final getItemInfoProvider =
    FutureProvider.family<ScanModel, String>((ref, barcode) async {
  var db = GetIt.I<DataBase>();
  return await db.getBarcodeInfo(code: barcode);
});

enum ConfirmSaleEnum { successful, idle }

@riverpod
class ConfirmSale extends _$ConfirmSale {
  @override
  FutureOr<ConfirmSaleEnum> build() async {
    return ConfirmSaleEnum.idle;
  }

  tryConfirmSale(
    SalesModel staff,
    String barcode,
    String receiver,
    ScanModel scanned,
    double cost,
  ) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      var fileID = await db.getFileFromBarcode(barcode);
      var pk = await db.getPKFromID(staff.brandID);
      await db.appendFileSales(barcode, staff, fileID, receiver, pk);
      var sender = await db.getAddressFromID(staff.brandID);
      //create receipt and send nft to owner and save nft id as receipt id

      var nftId = await db.createNFTReceipt(staff.brandName, "XMY", receiver);
      var transfer = Transfer(
        senderAddress: sender,
        receiverAddress: receiver,
        receiptID: nftId,
        brandID: staff.brandID,
        barcodeID: barcode,
        time: DateTime.now(),
        cost: cost,
        productID: scanned.productID!,
      );
      await db.saveTransfer(transfer);
      return ConfirmSaleEnum.successful;
    });
  }
}
