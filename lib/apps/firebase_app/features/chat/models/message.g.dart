// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      msg: json['msg'] as String?,
      toId: json['toId'] as String?,
      read: json['read'] as String?,
      type: $enumDecodeNullable(_$TypeEnumMap, json['type']),
      sent: json['sent'] as String?,
      fromId: json['fromId'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'toId': instance.toId,
      'read': instance.read,
      'type': instance.type?.toJson(),
      'sent': instance.sent,
      'fromId': instance.fromId,
    };

const _$TypeEnumMap = {
  Type.text: 'text',
  Type.image: 'image',
};
