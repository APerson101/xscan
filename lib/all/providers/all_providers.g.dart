// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sendHbarToReceiverHash() =>
    r'e679cc5a09a8a0e35b4ad6a758c8ea8455498822';

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

String _$configHash() => r'4d2b6972abb11e54a6e47bffccbdef98e90d00d8';

/// See also [config].
@ProviderFor(config)
final configProvider = AutoDisposeFutureProvider<void>.internal(
  config,
  name: r'configProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$configHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConfigRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
