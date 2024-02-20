// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_screen_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhoneImpl _$$PhoneImplFromJson(Map<String, dynamic> json) => _$PhoneImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$PhoneImplToJson(_$PhoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ageHash() => r'409bdf9eeabc84592ac672899b1a0bf02992b4c9';

/// See also [age].
@ProviderFor(age)
final ageProvider = AutoDisposeFutureProvider<int>.internal(
  age,
  name: r'ageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AgeRef = AutoDisposeFutureProviderRef<int>;
String _$riverpodScreenControllerHash() =>
    r'5fe2046816861ca48e59198239f2d448076c0310';

/// See also [RiverpodScreenController].
@ProviderFor(RiverpodScreenController)
final riverpodScreenControllerProvider = AutoDisposeAsyncNotifierProvider<
    RiverpodScreenController, List<Phone>>.internal(
  RiverpodScreenController.new,
  name: r'riverpodScreenControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$riverpodScreenControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RiverpodScreenController = AutoDisposeAsyncNotifier<List<Phone>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
