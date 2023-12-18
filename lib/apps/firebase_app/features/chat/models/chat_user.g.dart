// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatUserImpl _$$ChatUserImplFromJson(Map<String, dynamic> json) =>
    _$ChatUserImpl(
      image: json['image'] as String?,
      about: json['about'] as String?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      lastActive: json['last_active'] as String?,
      id: json['id'] as String?,
      isOnline: json['is_online'] as bool?,
      email: json['email'] as String?,
      pushToken: json['push_token'] as String?,
    );

Map<String, dynamic> _$$ChatUserImplToJson(_$ChatUserImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'about': instance.about,
      'name': instance.name,
      'created_at': instance.createdAt,
      'last_active': instance.lastActive,
      'id': instance.id,
      'is_online': instance.isOnline,
      'email': instance.email,
      'push_token': instance.pushToken,
    };
