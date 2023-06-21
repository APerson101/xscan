// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getNotificationsHash() => r'd74bbdb197a061d7f58a669b2ffb4dd1dc1b16a4';

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

typedef GetNotificationsRef
    = AutoDisposeFutureProviderRef<List<QuotationModel>>;

/// See also [getNotifications].
@ProviderFor(getNotifications)
const getNotificationsProvider = GetNotificationsFamily();

/// See also [getNotifications].
class GetNotificationsFamily extends Family<AsyncValue<List<QuotationModel>>> {
  /// See also [getNotifications].
  const GetNotificationsFamily();

  /// See also [getNotifications].
  GetNotificationsProvider call(
    String brandID,
  ) {
    return GetNotificationsProvider(
      brandID,
    );
  }

  @override
  GetNotificationsProvider getProviderOverride(
    covariant GetNotificationsProvider provider,
  ) {
    return call(
      provider.brandID,
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
  String? get name => r'getNotificationsProvider';
}

/// See also [getNotifications].
class GetNotificationsProvider
    extends AutoDisposeFutureProvider<List<QuotationModel>> {
  /// See also [getNotifications].
  GetNotificationsProvider(
    this.brandID,
  ) : super.internal(
          (ref) => getNotifications(
            ref,
            brandID,
          ),
          from: getNotificationsProvider,
          name: r'getNotificationsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getNotificationsHash,
          dependencies: GetNotificationsFamily._dependencies,
          allTransitiveDependencies:
              GetNotificationsFamily._allTransitiveDependencies,
        );

  final String brandID;

  @override
  bool operator ==(Object other) {
    return other is GetNotificationsProvider && other.brandID == brandID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brandID.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$acceptQuotationHash() => r'e93239fa5936e578c818091b9066cc843575ec15';
typedef AcceptQuotationRef = AutoDisposeProviderRef<dynamic>;

/// See also [acceptQuotation].
@ProviderFor(acceptQuotation)
const acceptQuotationProvider = AcceptQuotationFamily();

/// See also [acceptQuotation].
class AcceptQuotationFamily extends Family<dynamic> {
  /// See also [acceptQuotation].
  const AcceptQuotationFamily();

  /// See also [acceptQuotation].
  AcceptQuotationProvider call(
    QuotationModel quotation,
    Brand brand,
    BrandManufaturer transaction,
  ) {
    return AcceptQuotationProvider(
      quotation,
      brand,
      transaction,
    );
  }

  @override
  AcceptQuotationProvider getProviderOverride(
    covariant AcceptQuotationProvider provider,
  ) {
    return call(
      provider.quotation,
      provider.brand,
      provider.transaction,
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
  String? get name => r'acceptQuotationProvider';
}

/// See also [acceptQuotation].
class AcceptQuotationProvider extends AutoDisposeProvider<dynamic> {
  /// See also [acceptQuotation].
  AcceptQuotationProvider(
    this.quotation,
    this.brand,
    this.transaction,
  ) : super.internal(
          (ref) => acceptQuotation(
            ref,
            quotation,
            brand,
            transaction,
          ),
          from: acceptQuotationProvider,
          name: r'acceptQuotationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$acceptQuotationHash,
          dependencies: AcceptQuotationFamily._dependencies,
          allTransitiveDependencies:
              AcceptQuotationFamily._allTransitiveDependencies,
        );

  final QuotationModel quotation;
  final Brand brand;
  final BrandManufaturer transaction;

  @override
  bool operator ==(Object other) {
    return other is AcceptQuotationProvider &&
        other.quotation == quotation &&
        other.brand == brand &&
        other.transaction == transaction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quotation.hashCode);
    hash = _SystemHash.combine(hash, brand.hashCode);
    hash = _SystemHash.combine(hash, transaction.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
