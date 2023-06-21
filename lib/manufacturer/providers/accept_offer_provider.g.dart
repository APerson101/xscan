// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_offer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$acceptOfferHash() => r'64a3cd7bd663bddf282fb751dd60a1781b325420';

/// See also [AcceptOffer].
@ProviderFor(AcceptOffer)
final acceptOfferProvider = AutoDisposeAsyncNotifierProvider<AcceptOffer,
    AcceptOfferCreationState>.internal(
  AcceptOffer.new,
  name: r'acceptOfferProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$acceptOfferHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AcceptOffer = AutoDisposeAsyncNotifier<AcceptOfferCreationState>;
String _$sendQuotationHash() => r'c76551f19e51fa2169ac0ed8cba41cf5c9e9181a';

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

abstract class _$SendQuotation extends BuildlessAutoDisposeNotifier<dynamic> {
  late final int amount;
  late final String brandID;
  late final Manufacturer manufacturer;
  late final BrandManufaturer transaction;

  dynamic build(
    int amount,
    String brandID,
    Manufacturer manufacturer,
    BrandManufaturer transaction,
  );
}

/// See also [SendQuotation].
@ProviderFor(SendQuotation)
const sendQuotationProvider = SendQuotationFamily();

/// See also [SendQuotation].
class SendQuotationFamily extends Family<dynamic> {
  /// See also [SendQuotation].
  const SendQuotationFamily();

  /// See also [SendQuotation].
  SendQuotationProvider call(
    int amount,
    String brandID,
    Manufacturer manufacturer,
    BrandManufaturer transaction,
  ) {
    return SendQuotationProvider(
      amount,
      brandID,
      manufacturer,
      transaction,
    );
  }

  @override
  SendQuotationProvider getProviderOverride(
    covariant SendQuotationProvider provider,
  ) {
    return call(
      provider.amount,
      provider.brandID,
      provider.manufacturer,
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
  String? get name => r'sendQuotationProvider';
}

/// See also [SendQuotation].
class SendQuotationProvider
    extends AutoDisposeNotifierProviderImpl<SendQuotation, dynamic> {
  /// See also [SendQuotation].
  SendQuotationProvider(
    this.amount,
    this.brandID,
    this.manufacturer,
    this.transaction,
  ) : super.internal(
          () => SendQuotation()
            ..amount = amount
            ..brandID = brandID
            ..manufacturer = manufacturer
            ..transaction = transaction,
          from: sendQuotationProvider,
          name: r'sendQuotationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendQuotationHash,
          dependencies: SendQuotationFamily._dependencies,
          allTransitiveDependencies:
              SendQuotationFamily._allTransitiveDependencies,
        );

  final int amount;
  final String brandID;
  final Manufacturer manufacturer;
  final BrandManufaturer transaction;

  @override
  bool operator ==(Object other) {
    return other is SendQuotationProvider &&
        other.amount == amount &&
        other.brandID == brandID &&
        other.manufacturer == manufacturer &&
        other.transaction == transaction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, brandID.hashCode);
    hash = _SystemHash.combine(hash, manufacturer.hashCode);
    hash = _SystemHash.combine(hash, transaction.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  dynamic runNotifierBuild(
    covariant SendQuotation notifier,
  ) {
    return notifier.build(
      amount,
      brandID,
      manufacturer,
      transaction,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
