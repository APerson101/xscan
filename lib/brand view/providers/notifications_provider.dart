import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/models/escrow.dart';

import '../../manufacturer/models/quotation.dart';
import '../../manufacturer/providers/accept_offer_provider.dart';
import '../models/brand.dart';
import '../models/brand_manufacturer.dart';

part 'notifications_provider.g.dart';

@riverpod
FutureOr<List<QuotationModel>> getNotifications(
    GetNotificationsRef ref, String brandID) async {
  var db = GetIt.I<DataBase>();
  return (await db.loadBrandNotifications(id: brandID));
}

@riverpod
acceptQuotation(AcceptQuotationRef ref, QuotationModel quotation, Brand brand,
    BrandManufaturer transaction) async {
  var db = GetIt.I<DataBase>();
  await db.sendFundsEscrow(brand.accountID, brand.privateKey, quotation.amount);
  await db.saveEscrowToHistory(Escrow(
      senderAccountID: brand.id,
      receiverAccountID: quotation.manu.accountID,
      amount: quotation.amount,
      created: DateTime.now(),
      id: const Uuid().v4(),
      status: EscrowStatusEnum.pending));
  ref.watch(acceptOfferProvider.notifier).acceptOffer(
      transaction.id, transaction.product, transaction.manufacturerID);

  // send notification to manufacturer to start production
}
