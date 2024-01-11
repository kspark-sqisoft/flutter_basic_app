import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int isDone;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = 0,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      isDone,
    ];
  }

  @override
  String toString() {
    return 'Task(id:$id, title:$title, description:$description, isDone:$isDone)';
  }
}
