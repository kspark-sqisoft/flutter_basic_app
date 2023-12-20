// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String? get msg => throw _privateConstructorUsedError;
  String? get toId => throw _privateConstructorUsedError;
  String? get read => throw _privateConstructorUsedError;
  Type? get type => throw _privateConstructorUsedError;
  String? get sent => throw _privateConstructorUsedError;
  String? get fromId => throw _privateConstructorUsedError;
  String? get fromName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String? msg,
      String? toId,
      String? read,
      Type? type,
      String? sent,
      String? fromId,
      String? fromName});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = freezed,
    Object? toId = freezed,
    Object? read = freezed,
    Object? type = freezed,
    Object? sent = freezed,
    Object? fromId = freezed,
    Object? fromName = freezed,
  }) {
    return _then(_value.copyWith(
      msg: freezed == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String?,
      toId: freezed == toId
          ? _value.toId
          : toId // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Type?,
      sent: freezed == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as String?,
      fromId: freezed == fromId
          ? _value.fromId
          : fromId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromName: freezed == fromName
          ? _value.fromName
          : fromName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? msg,
      String? toId,
      String? read,
      Type? type,
      String? sent,
      String? fromId,
      String? fromName});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = freezed,
    Object? toId = freezed,
    Object? read = freezed,
    Object? type = freezed,
    Object? sent = freezed,
    Object? fromId = freezed,
    Object? fromName = freezed,
  }) {
    return _then(_$MessageImpl(
      msg: freezed == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String?,
      toId: freezed == toId
          ? _value.toId
          : toId // ignore: cast_nullable_to_non_nullable
              as String?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Type?,
      sent: freezed == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as String?,
      fromId: freezed == fromId
          ? _value.fromId
          : fromId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromName: freezed == fromName
          ? _value.fromName
          : fromName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MessageImpl implements _Message {
  _$MessageImpl(
      {this.msg,
      this.toId,
      this.read,
      this.type,
      this.sent,
      this.fromId,
      this.fromName});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String? msg;
  @override
  final String? toId;
  @override
  final String? read;
  @override
  final Type? type;
  @override
  final String? sent;
  @override
  final String? fromId;
  @override
  final String? fromName;

  @override
  String toString() {
    return 'Message(msg: $msg, toId: $toId, read: $read, type: $type, sent: $sent, fromId: $fromId, fromName: $fromName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.toId, toId) || other.toId == toId) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.fromId, fromId) || other.fromId == fromId) &&
            (identical(other.fromName, fromName) ||
                other.fromName == fromName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, msg, toId, read, type, sent, fromId, fromName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  factory _Message(
      {final String? msg,
      final String? toId,
      final String? read,
      final Type? type,
      final String? sent,
      final String? fromId,
      final String? fromName}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String? get msg;
  @override
  String? get toId;
  @override
  String? get read;
  @override
  Type? get type;
  @override
  String? get sent;
  @override
  String? get fromId;
  @override
  String? get fromName;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
