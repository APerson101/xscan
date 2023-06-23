// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_place_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$marketPlaceHash() => r'e581f187e0be0f8f954b95851a96dc46dad61069';

/// See also [MarketPlace].
@ProviderFor(MarketPlace)
final marketPlaceProvider = AutoDisposeAsyncNotifierProvider<
    MarketPlace,
    List<
        ({
          String itemBarcode,
          ItemOwnershipHistory itemHistory,
          double price,
          List<String> productComments,
          String productID,
          List<String> productImages,
          String productName,
          String sellerImage
        })>>.internal(
  MarketPlace.new,
  name: r'marketPlaceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$marketPlaceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MarketPlace = AutoDisposeAsyncNotifier<
    List<
        ({
          String itemBarcode,
          ItemOwnershipHistory itemHistory,
          double price,
          List<String> productComments,
          String productID,
          List<String> productImages,
          String productName,
          String sellerImage
        })>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
