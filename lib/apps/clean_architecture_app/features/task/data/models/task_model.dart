import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/task.dart';
part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    super.isDone,
  });
  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'description': description, 'isDone': isDone};

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        isDone: json['isDone'] as int,
      );
}
