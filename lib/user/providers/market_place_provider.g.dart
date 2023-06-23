// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_place_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getUserFromIdHash() => r'3ff8e9b9003d12f2d7dbbf58a7890bc8983af7a5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef GetUserFromIdRef = AutoDisposeFutureProviderRef<UserModel>;

/// See also [getUserFromId].
@ProviderFor(getUserFromId)
const getUserFromIdProvider = GetUserFromIdFamily();

/// See also [getUserFromId].
class GetUserFromIdFamily extends Family<AsyncValue<UserModel>> {
  /// See also [getUserFromId].
  const GetUserFromIdFamily();

  /// See also [getUserFromId].
  GetUserFromIdProvider call(
    String id,
  ) {
    return GetUserFromIdProvider(
      id,
    );
  }

  @override
  GetUserFromIdProvider getProviderOverride(
    covariant GetUserFromIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getUserFromIdProvider';
}

/// See also [getUserFromId].
class GetUserFromIdProvider extends AutoDisposeFutureProvider<UserModel> {
  /// See also [getUserFromId].
  GetUserFromIdProvider(
    this.id,
  ) : super.internal(
          (ref) => getUserFromId(
            ref,
            id,
          ),
          from: getUserFromIdProvider,
          name: r'getUserFromIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserFromIdHash,
          dependencies: GetUserFromIdFamily._dependencies,
          allTransitiveDependencies:
              GetUserFromIdFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetUserFromIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$loadUserAssetsHash() => r'ed4aa524985815a5dad350418d9b95699237a867';

/// See also [loadUserAssets].
@ProviderFor(loadUserAssets)
final loadUserAssetsProvider = AutoDisposeFutureProvider<
    List<
        ({
          List<String> imageLinks,
          ItemOwnershipHistory ownership,
          String productName,
          String review,
          List<int> stars,
          Transfer tranfer
        })>>.internal(
  loadUserAssets,
  name: r'loadUserAssetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadUserAssetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LoadUserAssetsRef = AutoDisposeFutureProviderRef<
    List<
        ({
          List<String> imageLinks,
          ItemOwnershipHistory ownership,
          String productName,
          String review,
          List<int> stars,
          Transfer tranfer
        })>>;
String _$putAssetForSaleHash() => r'41e228821953bf134a06a814c1da5f64ab467cb4';
typedef PutAssetForSaleRef = AutoDisposeFutureProviderRef<dynamic>;

/// See also [putAssetForSale].
@ProviderFor(putAssetForSale)
const putAssetForSaleProvider = PutAssetForSaleFamily();

/// See also [putAssetForSale].
class PutAssetForSaleFamily extends Family<AsyncValue<dynamic>> {
  /// See also [putAssetForSale].
  const PutAssetForSaleFamily();

  /// See also [putAssetForSale].
  PutAssetForSaleProvider call(
    UserModel model,
    int amount,
    String barcode,
  ) {
    return PutAssetForSaleProvider(
      model,
      amount,
      barcode,
    );
  }

  @override
  PutAssetForSaleProvider getProviderOverride(
    covariant PutAssetForSaleProvider provider,
  ) {
    return call(
      provider.model,
      provider.amount,
      provider.barcode,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'putAssetForSaleProvider';
}

/// See also [putAssetForSale].
class PutAssetForSaleProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [putAssetForSale].
  PutAssetForSaleProvider(
    this.model,
    this.amount,
    this.barcode,
  ) : super.internal(
          (ref) => putAssetForSale(
            ref,
            model,
            amount,
            barcode,
          ),
          from: putAssetForSaleProvider,
          name: r'putAssetForSaleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$putAssetForSaleHash,
          dependencies: PutAssetForSaleFamily._dependencies,
          allTransitiveDependencies:
              PutAssetForSaleFamily._allTransitiveDependencies,
        );

  final UserModel model;
  final int amount;
  final String barcode;

  @override
  bool operator ==(Object other) {
    return other is PutAssetForSaleProvider &&
        other.model == model &&
        other.amount == amount &&
        other.barcode == barcode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, barcode.hashCode);

    return _SystemHash.finish(hash);
  }
}

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
