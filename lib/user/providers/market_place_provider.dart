import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/helpers/db2.dart';

import '../../brand view/models/transfer.dart';
import '../../brand view/models/txns_history.dart';
import '../../brand view/models/usermodel.dart';
import '../nft_details.dart';

part 'market_place_provider.g.dart';

typedef ItemForSale = ({
  List<String> productImages,
  String productID,
  String productName,
  List<String> productComments,
  double price,
  String sellerImage,
  String nftID,
  ItemOwnershipHistory itemHistory,
  String itemBarcode
});

@riverpod
class MarketPlace extends _$MarketPlace {
  @override
  FutureOr<List<ItemForSale>> build() async {
    var data = await fetchMarketPlaceItems();
    state = AsyncData(data);
    return await Future.delayed((const Duration(seconds: 0)), () => (data));
  }

  Future<List<ItemForSale>> fetchMarketPlaceItems() async {
    return await GetIt.I<DataBase>().getAllForSale();
  }
}

@riverpod
FutureOr<UserModel> getUserFromId(GetUserFromIdRef ref, String id) async {
  return await GetIt.I<DataBase>().getUserFromID(id);
}

@riverpod
FutureOr<List<NftInfo>> loadUserAssets(
    LoadUserAssetsRef ref, String accountID) async {
  var tokens =
      (await GetIt.I<BaseHelper>().retreiveBalance(accountID: accountID))
          .tokens;
  print(tokens);
  List<String> tokenIDs = [];
  for (var token in tokens) {
    tokenIDs.add(token.tokenId);
  }
  return await GetIt.I<BaseHelper>().getNFTData(tokenIDs);
}

@riverpod
FutureOr putAssetForSale(PutAssetForSaleRef ref, UserModel model, int amount,
    String barcode, String nftID) async {
  await GetIt.I<DataBase>().addItemforSale(
      barcode: barcode, price: amount, seller: model.accountID, nftID: nftID);
}

@riverpod
FutureOr confirmNFTPurchase(
    ConfirmNFTPurchaseRef ref, ItemForSale item, UserModel user) async {
  await GetIt.I<DataBase>().purchaseItem(
      item: item, sender: user.accountID, senderPK: user.privateKey);
  ref.watch(purchaseHandler.notifier).state = 1;
}
