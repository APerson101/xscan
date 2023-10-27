// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBrandInfoProviderHash() =>
    r'b0e20378a391f924f7ac0aacc22820f448b44241';

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

typedef GetBrandInfoProviderRef
    = AutoDisposeFutureProviderRef<(Brand, List<QuotationModel>)>;

/// See also [getBrandInfoProvider].
@ProviderFor(getBrandInfoProvider)
const getBrandInfoProviderProvider = GetBrandInfoProviderFamily();

/// See also [getBrandInfoProvider].
class GetBrandInfoProviderFamily
    extends Family<AsyncValue<(Brand, List<QuotationModel>)>> {
  /// See also [getBrandInfoProvider].
  const GetBrandInfoProviderFamily();

  /// See also [getBrandInfoProvider].
  GetBrandInfoProviderProvider call(
    String brandID,
  ) {
    return GetBrandInfoProviderProvider(
      brandID,
    );
  }

  @override
  GetBrandInfoProviderProvider getProviderOverride(
    covariant GetBrandInfoProviderProvider provider,
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
  String? get name => r'getBrandInfoProviderProvider';
}

/// See also [getBrandInfoProvider].
class GetBrandInfoProviderProvider
    extends AutoDisposeFutureProvider<(Brand, List<QuotationModel>)> {
  /// See also [getBrandInfoProvider].
  GetBrandInfoProviderProvider(
    this.brandID,
  ) : super.internal(
          (ref) => getBrandInfoProvider(
            ref,
            brandID,
          ),
          from: getBrandInfoProviderProvider,
          name: r'getBrandInfoProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBrandInfoProviderHash,
          dependencies: GetBrandInfoProviderFamily._dependencies,
          allTransitiveDependencies:
              GetBrandInfoProviderFamily._allTransitiveDependencies,
        );

  final String brandID;

  @override
  bool operator ==(Object other) {
    return other is GetBrandInfoProviderProvider && other.brandID == brandID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brandID.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$removeProductStateHash() =>
    r'8ef82266659242330f56efc2307b8b57f3e2b9e9';

/// See also [RemoveProductState].
@ProviderFor(RemoveProductState)
final removeProductStateProvider = AutoDisposeAsyncNotifierProvider<
    RemoveProductState, RemoveProductStateEnum>.internal(
  RemoveProductState.new,
  name: r'removeProductStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$removeProductStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RemoveProductState = AutoDisposeAsyncNotifier<RemoveProductStateEnum>;
String _$sendManuRequestStateHash() =>
    r'43a1ae032b41c98bcfe67a5a4bfd5c06d75cc831';

/// See also [SendManuRequestState].
@ProviderFor(SendManuRequestState)
final sendManuRequestStateProvider = AutoDisposeAsyncNotifierProvider<
    SendManuRequestState, SendManuRequestStateEnum>.internal(
  SendManuRequestState.new,
  name: r'sendManuRequestStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sendManuRequestStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendManuRequestState
    = AutoDisposeAsyncNotifier<SendManuRequestStateEnum>;
String _$removeManuRequestStateHash() =>
    r'269fe3cf302168454dc6805add1c57a620ccedcd';

/// See also [RemoveManuRequestState].
@ProviderFor(RemoveManuRequestState)
final removeManuRequestStateProvider = AutoDisposeAsyncNotifierProvider<
    RemoveManuRequestState, RemoveManuRequestStateEnum>.internal(
  RemoveManuRequestState.new,
  name: r'removeManuRequestStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$removeManuRequestStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RemoveManuRequestState
    = AutoDisposeAsyncNotifier<RemoveManuRequestStateEnum>;
String _$approveProductStateHash() =>
    r'95e0041296fc5f30b8520d6de230f9bf3ae0572d';

/// See also [ApproveProductState].
@ProviderFor(ApproveProductState)
final approveProductStateProvider = AutoDisposeAsyncNotifierProvider<
    ApproveProductState, ApproveProductStateEnum>.internal(
  ApproveProductState.new,
  name: r'approveProductStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$approveProductStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ApproveProductState
    = AutoDisposeAsyncNotifier<ApproveProductStateEnum>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
