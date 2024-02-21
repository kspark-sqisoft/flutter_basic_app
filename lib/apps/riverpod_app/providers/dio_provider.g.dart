// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'1976ce3dff558d0d7f691ef108ee74dcf47ae0db';

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

/// See also [dio].
@ProviderFor(dio)
const dioProvider = DioFamily();

/// See also [dio].
class DioFamily extends Family<Dio> {
  /// See also [dio].
  const DioFamily();

  /// See also [dio].
  DioProvider call({
    BaseOptions? baseOptions,
  }) {
    return DioProvider(
      baseOptions: baseOptions,
    );
  }

  @override
  DioProvider getProviderOverride(
    covariant DioProvider provider,
  ) {
    return call(
      baseOptions: provider.baseOptions,
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
  String? get name => r'dioProvider';
}

/// See also [dio].
class DioProvider extends AutoDisposeProvider<Dio> {
  /// See also [dio].
  DioProvider({
    BaseOptions? baseOptions,
  }) : this._internal(
          (ref) => dio(
            ref as DioRef,
            baseOptions: baseOptions,
          ),
          from: dioProvider,
          name: r'dioProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
          dependencies: DioFamily._dependencies,
          allTransitiveDependencies: DioFamily._allTransitiveDependencies,
          baseOptions: baseOptions,
        );

  DioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.baseOptions,
  }) : super.internal();

  final BaseOptions? baseOptions;

  @override
  Override overrideWith(
    Dio Function(DioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DioProvider._internal(
        (ref) => create(ref as DioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        baseOptions: baseOptions,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Dio> createElement() {
    return _DioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DioProvider && other.baseOptions == baseOptions;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, baseOptions.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DioRef on AutoDisposeProviderRef<Dio> {
  /// The parameter `baseOptions` of this provider.
  BaseOptions? get baseOptions;
}

class _DioProviderElement extends AutoDisposeProviderElement<Dio> with DioRef {
  _DioProviderElement(super.provider);

  @override
  BaseOptions? get baseOptions => (origin as DioProvider).baseOptions;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
