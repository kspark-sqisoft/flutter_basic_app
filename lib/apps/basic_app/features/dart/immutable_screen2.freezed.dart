// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'immutable_screen2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FreezedClass _$FreezedClassFromJson(Map<String, dynamic> json) {
  return _FreezedClass.fromJson(json);
}

/// @nodoc
mixin _$FreezedClass {
  int? get id => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  List<int>? get list => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreezedClassCopyWith<FreezedClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezedClassCopyWith<$Res> {
  factory $FreezedClassCopyWith(
          FreezedClass value, $Res Function(FreezedClass) then) =
      _$FreezedClassCopyWithImpl<$Res, FreezedClass>;
  @useResult
  $Res call({int? id, int? level, List<int>? list});
}

/// @nodoc
class _$FreezedClassCopyWithImpl<$Res, $Val extends FreezedClass>
    implements $FreezedClassCopyWith<$Res> {
  _$FreezedClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? list = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreezedClassImplCopyWith<$Res>
    implements $FreezedClassCopyWith<$Res> {
  factory _$$FreezedClassImplCopyWith(
          _$FreezedClassImpl value, $Res Function(_$FreezedClassImpl) then) =
      __$$FreezedClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int? level, List<int>? list});
}

/// @nodoc
class __$$FreezedClassImplCopyWithImpl<$Res>
    extends _$FreezedClassCopyWithImpl<$Res, _$FreezedClassImpl>
    implements _$$FreezedClassImplCopyWith<$Res> {
  __$$FreezedClassImplCopyWithImpl(
      _$FreezedClassImpl _value, $Res Function(_$FreezedClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? list = freezed,
  }) {
    return _then(_$FreezedClassImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      list: freezed == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FreezedClassImpl implements _FreezedClass {
  const _$FreezedClassImpl({this.id, this.level, final List<int>? list})
      : _list = list;

  factory _$FreezedClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezedClassImplFromJson(json);

  @override
  final int? id;
  @override
  final int? level;
  final List<int>? _list;
  @override
  List<int>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FreezedClass(id: $id, level: $level, list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreezedClassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, level, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezedClassImplCopyWith<_$FreezedClassImpl> get copyWith =>
      __$$FreezedClassImplCopyWithImpl<_$FreezedClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreezedClassImplToJson(
      this,
    );
  }
}

abstract class _FreezedClass implements FreezedClass {
  const factory _FreezedClass(
      {final int? id,
      final int? level,
      final List<int>? list}) = _$FreezedClassImpl;

  factory _FreezedClass.fromJson(Map<String, dynamic> json) =
      _$FreezedClassImpl.fromJson;

  @override
  int? get id;
  @override
  int? get level;
  @override
  List<int>? get list;
  @override
  @JsonKey(ignore: true)
  _$$FreezedClassImplCopyWith<_$FreezedClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
