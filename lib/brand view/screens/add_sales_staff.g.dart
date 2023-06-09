// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_sales_staff.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createStaffHash() => r'2e4e878068db4b74fcd1338f81ca7e8d96b54b68';

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

typedef CreateStaffRef = AutoDisposeFutureProviderRef<dynamic>;

/// See also [createStaff].
@ProviderFor(createStaff)
const createStaffProvider = CreateStaffFamily();

/// See also [createStaff].
class CreateStaffFamily extends Family<AsyncValue<dynamic>> {
  /// See also [createStaff].
  const CreateStaffFamily();

  /// See also [createStaff].
  CreateStaffProvider call(
    SalesModel sales,
  ) {
    return CreateStaffProvider(
      sales,
    );
  }

  @override
  CreateStaffProvider getProviderOverride(
    covariant CreateStaffProvider provider,
  ) {
    return call(
      provider.sales,
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
  String? get name => r'createStaffProvider';
}

/// See also [createStaff].
class CreateStaffProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [createStaff].
  CreateStaffProvider(
    this.sales,
  ) : super.internal(
          (ref) => createStaff(
            ref,
            sales,
          ),
          from: createStaffProvider,
          name: r'createStaffProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createStaffHash,
          dependencies: CreateStaffFamily._dependencies,
          allTransitiveDependencies:
              CreateStaffFamily._allTransitiveDependencies,
        );

  final SalesModel sales;

  @override
  bool operator ==(Object other) {
    return other is CreateStaffProvider && other.sales == sales;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sales.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
