// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_basic_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'website': instance.website,
      'company': instance.company,
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      street: json['street'] as String?,
      suite: json['suite'] as String?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      geo: json['geo'] == null
          ? null
          : Geo.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      name: json['name'] as String?,
      catchPhrase: json['catchPhrase'] as String?,
      bs: json['bs'] as String?,
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };

_$GeoImpl _$$GeoImplFromJson(Map<String, dynamic> json) => _$GeoImpl(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );

Map<String, dynamic> _$$GeoImplToJson(_$GeoImpl instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      activity: json['activity'] as String?,
      type: json['type'] as String?,
      participants: (json['participants'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      link: json['link'] as String?,
      key: json['key'] as String?,
      accessibility: (json['accessibility'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'type': instance.type,
      'participants': instance.participants,
      'price': instance.price,
      'link': instance.link,
      'key': instance.key,
      'accessibility': instance.accessibility,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$keesoonHash() => r'7a418a4b19109d46ee542c8534318242d3be651a';

/// See also [keesoon].
@ProviderFor(keesoon)
final keesoonProvider = Provider<String>.internal(
  keesoon,
  name: r'keesoonProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$keesoonHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KeesoonRef = ProviderRef<String>;
String _$helloHash() => r'5a14fe40526acbf42de754fe6d36d3ea6b2859d1';

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

/// See also [hello].
@ProviderFor(hello)
const helloProvider = HelloFamily();

/// See also [hello].
class HelloFamily extends Family<String> {
  /// See also [hello].
  const HelloFamily();

  /// See also [hello].
  HelloProvider call({
    required String yourName,
  }) {
    return HelloProvider(
      yourName: yourName,
    );
  }

  @override
  HelloProvider getProviderOverride(
    covariant HelloProvider provider,
  ) {
    return call(
      yourName: provider.yourName,
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
  String? get name => r'helloProvider';
}

/// See also [hello].
class HelloProvider extends AutoDisposeProvider<String> {
  /// See also [hello].
  HelloProvider({
    required String yourName,
  }) : this._internal(
          (ref) => hello(
            ref as HelloRef,
            yourName: yourName,
          ),
          from: helloProvider,
          name: r'helloProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$helloHash,
          dependencies: HelloFamily._dependencies,
          allTransitiveDependencies: HelloFamily._allTransitiveDependencies,
          yourName: yourName,
        );

  HelloProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.yourName,
  }) : super.internal();

  final String yourName;

  @override
  Override overrideWith(
    String Function(HelloRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HelloProvider._internal(
        (ref) => create(ref as HelloRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        yourName: yourName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _HelloProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HelloProvider && other.yourName == yourName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, yourName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HelloRef on AutoDisposeProviderRef<String> {
  /// The parameter `yourName` of this provider.
  String get yourName;
}

class _HelloProviderElement extends AutoDisposeProviderElement<String>
    with HelloRef {
  _HelloProviderElement(super.provider);

  @override
  String get yourName => (origin as HelloProvider).yourName;
}

String _$tickerHash() => r'fae50b5977a1a7392bf9fbb9bd2b21177592415a';

/// See also [ticker].
@ProviderFor(ticker)
final tickerProvider = AutoDisposeStreamProvider<int>.internal(
  ticker,
  name: r'tickerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tickerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TickerRef = AutoDisposeStreamProviderRef<int>;
String _$usersHash() => r'faa3c72218a296e39ddf85751610e9d8e98b0c7f';

/// See also [users].
@ProviderFor(users)
final usersProvider = AutoDisposeFutureProvider<List<User>>.internal(
  users,
  name: r'usersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersRef = AutoDisposeFutureProviderRef<List<User>>;
String _$userHash() => r'dbace9843d59b8ca934d1c8086d0aec793de468d';

/// See also [user].
@ProviderFor(user)
const userProvider = UserFamily();

/// See also [user].
class UserFamily extends Family<AsyncValue<User>> {
  /// See also [user].
  const UserFamily();

  /// See also [user].
  UserProvider call({
    required int id,
  }) {
    return UserProvider(
      id: id,
    );
  }

  @override
  UserProvider getProviderOverride(
    covariant UserProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'userProvider';
}

/// See also [user].
class UserProvider extends AutoDisposeFutureProvider<User> {
  /// See also [user].
  UserProvider({
    required int id,
  }) : this._internal(
          (ref) => user(
            ref as UserRef,
            id: id,
          ),
          from: userProvider,
          name: r'userProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
          dependencies: UserFamily._dependencies,
          allTransitiveDependencies: UserFamily._allTransitiveDependencies,
          id: id,
        );

  UserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<User> Function(UserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProvider._internal(
        (ref) => create(ref as UserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<User> createElement() {
    return _UserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserRef on AutoDisposeFutureProviderRef<User> {
  /// The parameter `id` of this provider.
  int get id;
}

class _UserProviderElement extends AutoDisposeFutureProviderElement<User>
    with UserRef {
  _UserProviderElement(super.provider);

  @override
  int get id => (origin as UserProvider).id;
}

String _$counterHash() => r'9da34bdbe9491c21cbe6f1f114e0ffb244655214';

/// See also [Counter].
@ProviderFor(Counter)
final counterProvider = AutoDisposeNotifierProvider<Counter, int>.internal(
  Counter.new,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Counter = AutoDisposeNotifier<int>;
String _$normalActivityHash() => r'72a07e125c55134436b93fb1cc317d783b96ebd8';

/// See also [NormalActivity].
@ProviderFor(NormalActivity)
final normalActivityProvider =
    AutoDisposeNotifierProvider<NormalActivity, ActivityState>.internal(
  NormalActivity.new,
  name: r'normalActivityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$normalActivityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NormalActivity = AutoDisposeNotifier<ActivityState>;
String _$asyncActivityHash() => r'0f6d5bd7e8f231e031cecfd33505742fff0f9bde';

/// See also [AsyncActivity].
@ProviderFor(AsyncActivity)
final asyncActivityProvider =
    AutoDisposeAsyncNotifierProvider<AsyncActivity, Activity>.internal(
  AsyncActivity.new,
  name: r'asyncActivityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncActivityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncActivity = AutoDisposeAsyncNotifier<Activity>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
