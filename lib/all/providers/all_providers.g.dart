// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getHbarBalanceHash() => r'd2fc12315fe8970ad3362dd9836068accca457b1';

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

typedef GetHbarBalanceRef = AutoDisposeFutureProviderRef<
    ({int hbar, List<({int balance, String tokenId})> tokens})>;

/// See also [getHbarBalance].
@ProviderFor(getHbarBalance)
const getHbarBalanceProvider = GetHbarBalanceFamily();

/// See also [getHbarBalance].
class GetHbarBalanceFamily extends Family<
    AsyncValue<({int hbar, List<({int balance, String tokenId})> tokens})>> {
  /// See also [getHbarBalance].
  const GetHbarBalanceFamily();

  /// See also [getHbarBalance].
  GetHbarBalanceProvider call(
    String accountID,
  ) {
    return GetHbarBalanceProvider(
      accountID,
    );
  }

  @override
  GetHbarBalanceProvider getProviderOverride(
    covariant GetHbarBalanceProvider provider,
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
  String? get name => r'getHbarBalanceProvider';
}

/// See also [getHbarBalance].
class GetHbarBalanceProvider extends AutoDisposeFutureProvider<
    ({int hbar, List<({int balance, String tokenId})> tokens})> {
  /// See also [getHbarBalance].
  GetHbarBalanceProvider(
    this.accountID,
  ) : super.internal(
          (ref) => getHbarBalance(
            ref,
            accountID,
          ),
          from: getHbarBalanceProvider,
          name: r'getHbarBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getHbarBalanceHash,
          dependencies: GetHbarBalanceFamily._dependencies,
          allTransitiveDependencies:
              GetHbarBalanceFamily._allTransitiveDependencies,
        );

  final String accountID;

  @override
  bool operator ==(Object other) {
    return other is GetHbarBalanceProvider && other.accountID == accountID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountID.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$sendHbarToReceiverHash() =>
    r'e679cc5a09a8a0e35b4ad6a758c8ea8455498822';
typedef SendHbarToReceiverRef = AutoDisposeFutureProviderRef<dynamic>;

/// See also [sendHbarToReceiver].
@ProviderFor(sendHbarToReceiver)
const sendHbarToReceiverProvider = SendHbarToReceiverFamily();

/// See also [sendHbarToReceiver].
class SendHbarToReceiverFamily extends Family<AsyncValue<dynamic>> {
  /// See also [sendHbarToReceiver].
  const SendHbarToReceiverFamily();

  /// See also [sendHbarToReceiver].
  SendHbarToReceiverProvider call(
    String receiverID,
    String senderAccountID,
    String senderPK,
    int amount,
  ) {
    return SendHbarToReceiverProvider(
      receiverID,
      senderAccountID,
      senderPK,
      amount,
    );
  }

  @override
  SendHbarToReceiverProvider getProviderOverride(
    covariant SendHbarToReceiverProvider provider,
  ) {
    return call(
      provider.receiverID,
      provider.senderAccountID,
      provider.senderPK,
      provider.amount,
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
  String? get name => r'sendHbarToReceiverProvider';
}

/// See also [sendHbarToReceiver].
class SendHbarToReceiverProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [sendHbarToReceiver].
  SendHbarToReceiverProvider(
    this.receiverID,
    this.senderAccountID,
    this.senderPK,
    this.amount,
  ) : super.internal(
          (ref) => sendHbarToReceiver(
            ref,
            receiverID,
            senderAccountID,
            senderPK,
            amount,
          ),
          from: sendHbarToReceiverProvider,
          name: r'sendHbarToReceiverProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendHbarToReceiverHash,
          dependencies: SendHbarToReceiverFamily._dependencies,
          allTransitiveDependencies:
              SendHbarToReceiverFamily._allTransitiveDependencies,
        );

  final String receiverID;
  final String senderAccountID;
  final String senderPK;
  final int amount;

  @override
  bool operator ==(Object other) {
    return other is SendHbarToReceiverProvider &&
        other.receiverID == receiverID &&
        other.senderAccountID == senderAccountID &&
        other.senderPK == senderPK &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, receiverID.hashCode);
    hash = _SystemHash.combine(hash, senderAccountID.hashCode);
    hash = _SystemHash.combine(hash, senderPK.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
