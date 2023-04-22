import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xscan/brand%20view/models/product.dart';

import '../helpers/db.dart';

part 'create_product_provider.g.dart';

enum ProductCreationStateEnum { successful, idle }

@riverpod
class ProductCreationState extends _$ProductCreationState {
  @override
  FutureOr<ProductCreationStateEnum> build() async {
    return ProductCreationStateEnum.idle;
  }

  createProduct(Product product, String brandID) async {
    state = await AsyncValue.guard(() async {
      var db = GetIt.I<DataBase>();
      await db.addProduct(product, brandID);
      // return Future.delayed(const Duration(seconds: 2), () {
      //   var type =
      //       Random.secure().nextInt(ProductCreationStateEnum.values.length);
      //   debugPrint(describeEnum(ProductCreationStateEnum.values[type]));
      return ProductCreationStateEnum.successful;
      // });
    });
  }
}
