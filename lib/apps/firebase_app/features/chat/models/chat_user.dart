import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_user.freezed.dart';
part 'chat_user.g.dart';

@freezed
class ChatUser with _$ChatUser {
  factory ChatUser({
    String? image,
    String? about,
    String? name,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'last_active') String? lastActive,
    String? id,
    @JsonKey(name: 'is_online') bool? isOnline,
    String? email,
    @JsonKey(name: 'push_token') String? pushToken,
  }) = _ChatUser;

  factory ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);
}
