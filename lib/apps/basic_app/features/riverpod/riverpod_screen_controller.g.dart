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

String _$riverpodScreenControllerHash() =>
    r'5647587776493c81a380ae17b50c5cd3f5428d87';

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
