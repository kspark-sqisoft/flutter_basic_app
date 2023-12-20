import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum Type {
  text,
  image;

  String toJson() => name;
  static Type fromJson(String json) => values.byName(json);
}

@freezed
class Message with _$Message {
  @JsonSerializable(explicitToJson: true)
  factory Message({
    String? msg,
    String? toId,
    String? read,
    Type? type,
    String? sent,
    String? fromId,
    String? fromName,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
