import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/helpers/db.dart';
import 'package:xscan/brand%20view/helpers/db2.dart';

import '../../brand view/models/transfer.dart';
import '../../brand view/models/txns_history.dart';
import '../../brand view/models/usermodel.dart';

part 'market_place_provider.g.dart';

typedef ItemForSale = ({
  List<String> productImages,
  String productID,
  String productName,
  List<String> productComments,
  double price,
  String sellerImage,
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
    // items for sale: /**
    //pics
    //seller stars
    //comments
    //price
    //seller image
    // Ownership History
    //*/
    return await GetIt.I<DataBase>().getAllForSale();
    return List.generate(
        20,
        (index) => (
              productImages: [],
              productID: 'testID',
              productName: "Balenciaga Bag",
              productComments: ['test comment 1', 'test comment 2'],
              price: 40.0,
              sellerImage: 'seller Image',
              itemHistory: ItemOwnershipHistory(
                  id: 'id',
                  barcode: 'barcode',
                  brandID: 'brandID',
                  owners: [
                    ...List.generate(
                        4,
                        (index) => Owner(
                            accountID: 'accountID',
                            amountPaid: 'amountPaid',
                            purchased: DateTime.now()))
                  ]),
              itemBarcode: "7831-5345-3453"
            ));
  }
}

@riverpod
FutureOr<UserModel> getUserFromId(GetUserFromIdRef ref, String id) async {
  return await GetIt.I<DataBase>().getUserFromID(id);
}

@riverpod
FutureOr<List<NftInfo>> loadUserAssets(LoadUserAssetsRef ref) async {
  return await GetIt.I<BaseHelper>().getNFTData(['0.0.14972043']);
}

@riverpod
FutureOr putAssetForSale(
    PutAssetForSaleRef ref, UserModel model, int amount, String barcode) async {
  await GetIt.I<DataBase>()
      .addItemforSale(barcode: barcode, price: amount, seller: model.accountID);
}
