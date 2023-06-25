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

String _$loadUserAssetsHash() => r'8d547d491e50e192df7a904cef64f2899a59bc2b';
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

/// See also [loadUserAssets].
@ProviderFor(loadUserAssets)
const loadUserAssetsProvider = LoadUserAssetsFamily();

/// See also [loadUserAssets].
class LoadUserAssetsFamily extends Family<
    AsyncValue<
        List<
            ({
              List<String> imageLinks,
              ItemOwnershipHistory ownership,
              String productName,
              String review,
              List<int> stars,
              Transfer tranfer
            })>>> {
  /// See also [loadUserAssets].
  const LoadUserAssetsFamily();

  /// See also [loadUserAssets].
  LoadUserAssetsProvider call(
    String accountID,
  ) {
    return LoadUserAssetsProvider(
      accountID,
    );
  }

  @override
  LoadUserAssetsProvider getProviderOverride(
    covariant LoadUserAssetsProvider provider,
  ) {
    return call(
      provider.accountID,
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
  String? get name => r'loadUserAssetsProvider';
}

/// See also [loadUserAssets].
class LoadUserAssetsProvider extends AutoDisposeFutureProvider<
    List<
        ({
          List<String> imageLinks,
          ItemOwnershipHistory ownership,
          String productName,
          String review,
          List<int> stars,
          Transfer tranfer
        })>> {
  /// See also [loadUserAssets].
  LoadUserAssetsProvider(
    this.accountID,
  ) : super.internal(
          (ref) => loadUserAssets(
            ref,
            accountID,
          ),
          from: loadUserAssetsProvider,
          name: r'loadUserAssetsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loadUserAssetsHash,
          dependencies: LoadUserAssetsFamily._dependencies,
          allTransitiveDependencies:
              LoadUserAssetsFamily._allTransitiveDependencies,
        );

  final String accountID;

  @override
  bool operator ==(Object other) {
    return other is LoadUserAssetsProvider && other.accountID == accountID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountID.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$putAssetForSaleHash() => r'7e493578917cff00546925e6477621f261820b37';
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
    String nftID,
  ) {
    return PutAssetForSaleProvider(
      model,
      amount,
      barcode,
      nftID,
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
      provider.nftID,
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
    this.nftID,
  ) : super.internal(
          (ref) => putAssetForSale(
            ref,
            model,
            amount,
            barcode,
            nftID,
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
  final String nftID;

  @override
  bool operator ==(Object other) {
    return other is PutAssetForSaleProvider &&
        other.model == model &&
        other.amount == amount &&
        other.barcode == barcode &&
        other.nftID == nftID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, barcode.hashCode);
    hash = _SystemHash.combine(hash, nftID.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$confirmNFTPurchaseHash() =>
    r'b0cc15637e78da572286a4d3038a247f90f54b0e';
typedef ConfirmNFTPurchaseRef = AutoDisposeFutureProviderRef<dynamic>;

/// See also [confirmNFTPurchase].
@ProviderFor(confirmNFTPurchase)
const confirmNFTPurchaseProvider = ConfirmNFTPurchaseFamily();

/// See also [confirmNFTPurchase].
class ConfirmNFTPurchaseFamily extends Family<AsyncValue<dynamic>> {
  /// See also [confirmNFTPurchase].
  const ConfirmNFTPurchaseFamily();

  /// See also [confirmNFTPurchase].
  ConfirmNFTPurchaseProvider call(
    ({
      String itemBarcode,
      ItemOwnershipHistory itemHistory,
      String nftID,
      double price,
      List<String> productComments,
      String productID,
      List<String> productImages,
      String productName,
      String sellerImage
    }) item,
    UserModel user,
  ) {
    return ConfirmNFTPurchaseProvider(
      item,
      user,
    );
  }

  @override
  ConfirmNFTPurchaseProvider getProviderOverride(
    covariant ConfirmNFTPurchaseProvider provider,
  ) {
    return call(
      provider.item,
      provider.user,
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
  String? get name => r'confirmNFTPurchaseProvider';
}

/// See also [confirmNFTPurchase].
class ConfirmNFTPurchaseProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [confirmNFTPurchase].
  ConfirmNFTPurchaseProvider(
    this.item,
    this.user,
  ) : super.internal(
          (ref) => confirmNFTPurchase(
            ref,
            item,
            user,
          ),
          from: confirmNFTPurchaseProvider,
          name: r'confirmNFTPurchaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$confirmNFTPurchaseHash,
          dependencies: ConfirmNFTPurchaseFamily._dependencies,
          allTransitiveDependencies:
              ConfirmNFTPurchaseFamily._allTransitiveDependencies,
        );

  final ({
    String itemBarcode,
    ItemOwnershipHistory itemHistory,
    String nftID,
    double price,
    List<String> productComments,
    String productID,
    List<String> productImages,
    String productName,
    String sellerImage
  }) item;
  final UserModel user;

  @override
  bool operator ==(Object other) {
    return other is ConfirmNFTPurchaseProvider &&
        other.item == item &&
        other.user == user;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);
    hash = _SystemHash.combine(hash, user.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$marketPlaceHash() => r'd990869ee869c9527923a2b0dd264d954c9d132d';

/// See also [MarketPlace].
@ProviderFor(MarketPlace)
final marketPlaceProvider = AutoDisposeAsyncNotifierProvider<
    MarketPlace,
    List<
        ({
          String itemBarcode,
          ItemOwnershipHistory itemHistory,
          String nftID,
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
          String nftID,
          double price,
          List<String> productComments,
          String productID,
          List<String> productImages,
          String productName,
          String sellerImage
        })>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
