// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manu_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loadManuInfoHash() => r'b8015dc699c2cf9891d28a8a96a96571069ad239';

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

typedef LoadManuInfoRef = AutoDisposeFutureProviderRef<
    (Manufacturer, List<BrandManufaturer>, List<Escrow?>)>;

/// See also [loadManuInfo].
@ProviderFor(loadManuInfo)
const loadManuInfoProvider = LoadManuInfoFamily();

/// See also [loadManuInfo].
class LoadManuInfoFamily extends Family<
    AsyncValue<(Manufacturer, List<BrandManufaturer>, List<Escrow?>)>> {
  /// See also [loadManuInfo].
  const LoadManuInfoFamily();

  /// See also [loadManuInfo].
  LoadManuInfoProvider call(
    String id,
  ) {
    return LoadManuInfoProvider(
      id,
    );
  }

  @override
  LoadManuInfoProvider getProviderOverride(
    covariant LoadManuInfoProvider provider,
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
  String? get name => r'loadManuInfoProvider';
}

/// See also [loadManuInfo].
class LoadManuInfoProvider extends AutoDisposeFutureProvider<
    (Manufacturer, List<BrandManufaturer>, List<Escrow?>)> {
  /// See also [loadManuInfo].
  LoadManuInfoProvider(
    this.id,
  ) : super.internal(
          (ref) => loadManuInfo(
            ref,
            id,
          ),
          from: loadManuInfoProvider,
          name: r'loadManuInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loadManuInfoHash,
          dependencies: LoadManuInfoFamily._dependencies,
          allTransitiveDependencies:
              LoadManuInfoFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is LoadManuInfoProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getBrandHash() => r'0e0ad5e9ef6f73aa49f52c8f65dbe125e759efcc';
typedef GetBrandRef = AutoDisposeFutureProviderRef<Brand>;

/// See also [getBrand].
@ProviderFor(getBrand)
const getBrandProvider = GetBrandFamily();

/// See also [getBrand].
class GetBrandFamily extends Family<AsyncValue<Brand>> {
  /// See also [getBrand].
  const GetBrandFamily();

  /// See also [getBrand].
  GetBrandProvider call(
    String id,
  ) {
    return GetBrandProvider(
      id,
    );
  }

  @override
  GetBrandProvider getProviderOverride(
    covariant GetBrandProvider provider,
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
  String? get name => r'getBrandProvider';
}

/// See also [getBrand].
class GetBrandProvider extends AutoDisposeFutureProvider<Brand> {
  /// See also [getBrand].
  GetBrandProvider(
    this.id,
  ) : super.internal(
          (ref) => getBrand(
            ref,
            id,
          ),
          from: getBrandProvider,
          name: r'getBrandProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBrandHash,
          dependencies: GetBrandFamily._dependencies,
          allTransitiveDependencies: GetBrandFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is GetBrandProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$manuApprovePendingHash() =>
    r'c2aee91e93aa4ef2b0daccd6597ed7bfa1459496';

/// See also [ManuApprovePending].
@ProviderFor(ManuApprovePending)
final manuApprovePendingProvider = AutoDisposeAsyncNotifierProvider<
    ManuApprovePending, ManuApprovePendingEnum>.internal(
  ManuApprovePending.new,
  name: r'manuApprovePendingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$manuApprovePendingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ManuApprovePending = AutoDisposeAsyncNotifier<ManuApprovePendingEnum>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
