// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'momo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$requestToPayToEscrowHash() =>
    r'06a325859465fe2cf8901be431ab6509afbd77dd';

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

typedef RequestToPayToEscrowRef = AutoDisposeFutureProviderRef<String>;

/// See also [requestToPayToEscrow].
@ProviderFor(requestToPayToEscrow)
const requestToPayToEscrowProvider = RequestToPayToEscrowFamily();

/// See also [requestToPayToEscrow].
class RequestToPayToEscrowFamily extends Family<AsyncValue<String>> {
  /// See also [requestToPayToEscrow].
  const RequestToPayToEscrowFamily();

  /// See also [requestToPayToEscrow].
  RequestToPayToEscrowProvider call(
    String senderNumber,
    String receiverID,
    String businessID,
    int amount,
    int quantity,
    String businessName,
    String productName,
    String manufacturerName,
    String receiverNumber,
    String productID,
  ) {
    return RequestToPayToEscrowProvider(
      senderNumber,
      receiverID,
      businessID,
      amount,
      quantity,
      businessName,
      productName,
      manufacturerName,
      receiverNumber,
      productID,
    );
  }

  @override
  RequestToPayToEscrowProvider getProviderOverride(
    covariant RequestToPayToEscrowProvider provider,
  ) {
    return call(
      provider.senderNumber,
      provider.receiverID,
      provider.businessID,
      provider.amount,
      provider.quantity,
      provider.businessName,
      provider.productName,
      provider.manufacturerName,
      provider.receiverNumber,
      provider.productID,
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
  String? get name => r'requestToPayToEscrowProvider';
}

/// See also [requestToPayToEscrow].
class RequestToPayToEscrowProvider extends AutoDisposeFutureProvider<String> {
  /// See also [requestToPayToEscrow].
  RequestToPayToEscrowProvider(
    this.senderNumber,
    this.receiverID,
    this.businessID,
    this.amount,
    this.quantity,
    this.businessName,
    this.productName,
    this.manufacturerName,
    this.receiverNumber,
    this.productID,
  ) : super.internal(
          (ref) => requestToPayToEscrow(
            ref,
            senderNumber,
            receiverID,
            businessID,
            amount,
            quantity,
            businessName,
            productName,
            manufacturerName,
            receiverNumber,
            productID,
          ),
          from: requestToPayToEscrowProvider,
          name: r'requestToPayToEscrowProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$requestToPayToEscrowHash,
          dependencies: RequestToPayToEscrowFamily._dependencies,
          allTransitiveDependencies:
              RequestToPayToEscrowFamily._allTransitiveDependencies,
        );

  final String senderNumber;
  final String receiverID;
  final String businessID;
  final int amount;
  final int quantity;
  final String businessName;
  final String productName;
  final String manufacturerName;
  final String receiverNumber;
  final String productID;

  @override
  bool operator ==(Object other) {
    return other is RequestToPayToEscrowProvider &&
        other.senderNumber == senderNumber &&
        other.receiverID == receiverID &&
        other.businessID == businessID &&
        other.amount == amount &&
        other.quantity == quantity &&
        other.businessName == businessName &&
        other.productName == productName &&
        other.manufacturerName == manufacturerName &&
        other.receiverNumber == receiverNumber &&
        other.productID == productID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderNumber.hashCode);
    hash = _SystemHash.combine(hash, receiverID.hashCode);
    hash = _SystemHash.combine(hash, businessID.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, businessName.hashCode);
    hash = _SystemHash.combine(hash, productName.hashCode);
    hash = _SystemHash.combine(hash, manufacturerName.hashCode);
    hash = _SystemHash.combine(hash, receiverNumber.hashCode);
    hash = _SystemHash.combine(hash, productID.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getEscrowStatusForIDHash() =>
    r'6775983e07f9b97fd5a4ecc6f5ef52e05fbfcdf5';
typedef GetEscrowStatusForIDRef = AutoDisposeFutureProviderRef<List<Escrow?>>;

/// See also [getEscrowStatusForID].
@ProviderFor(getEscrowStatusForID)
const getEscrowStatusForIDProvider = GetEscrowStatusForIDFamily();

/// See also [getEscrowStatusForID].
class GetEscrowStatusForIDFamily extends Family<AsyncValue<List<Escrow?>>> {
  /// See also [getEscrowStatusForID].
  const GetEscrowStatusForIDFamily();

  /// See also [getEscrowStatusForID].
  GetEscrowStatusForIDProvider call(
    String id,
  ) {
    return GetEscrowStatusForIDProvider(
      id,
    );
  }

  @override
  GetEscrowStatusForIDProvider getProviderOverride(
    covariant GetEscrowStatusForIDProvider provider,
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
  String? get name => r'getEscrowStatusForIDProvider';
}

/// See also [getEscrowStatusForID].
class GetEscrowStatusForIDProvider
    extends AutoDisposeFutureProvider<List<Escrow?>> {
  /// See also [getEscrowStatusForID].
  GetEscrowStatusForIDProvider(
    this.id,
  ) : super.internal(
          (ref) => getEscrowStatusForID(
            ref,
            id,
          ),
          from: getEscrowStatusForIDProvider,
          name: r'getEscrowStatusForIDProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getEscrowStatusForIDHash,
          dependencies: GetEscrowStatusForIDFamily._dependencies,
          allTransitiveDependencies:
              GetEscrowStatusForIDFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetEscrowStatusForIDProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$disburseToBusinessHash() =>
    r'707e2ff924d27a02ceb059a7290b8cb10bcb65d8';
typedef DisburseToBusinessRef = AutoDisposeFutureProviderRef<List<Escrow?>>;

/// See also [disburseToBusiness].
@ProviderFor(disburseToBusiness)
const disburseToBusinessProvider = DisburseToBusinessFamily();

/// See also [disburseToBusiness].
class DisburseToBusinessFamily extends Family<AsyncValue<List<Escrow?>>> {
  /// See also [disburseToBusiness].
  const DisburseToBusinessFamily();

  /// See also [disburseToBusiness].
  DisburseToBusinessProvider call(
    String id,
  ) {
    return DisburseToBusinessProvider(
      id,
    );
  }

  @override
  DisburseToBusinessProvider getProviderOverride(
    covariant DisburseToBusinessProvider provider,
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
  String? get name => r'disburseToBusinessProvider';
}

/// See also [disburseToBusiness].
class DisburseToBusinessProvider
    extends AutoDisposeFutureProvider<List<Escrow?>> {
  /// See also [disburseToBusiness].
  DisburseToBusinessProvider(
    this.id,
  ) : super.internal(
          (ref) => disburseToBusiness(
            ref,
            id,
          ),
          from: disburseToBusinessProvider,
          name: r'disburseToBusinessProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$disburseToBusinessHash,
          dependencies: DisburseToBusinessFamily._dependencies,
          allTransitiveDependencies:
              DisburseToBusinessFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is DisburseToBusinessProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
