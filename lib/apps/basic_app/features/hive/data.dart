import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'data.freezed.dart';
part 'data.g.dart';

@HiveType(typeId: 1)
@freezed
class Data with _$Data {
  factory Data({
    @HiveField(0) int? id,
    @HiveField(1) String? message,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
