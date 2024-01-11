import 'package:equatable/equatable.dart';

import '../../domain/entities/task.dart';

enum TasksStatus { initial, loading, loaded, failure }

final class TasksState extends Equatable {
  const TasksState({
    this.status = TasksStatus.initial,
    this.tasks = const <Task>[],
  });

  final TasksStatus status;
  final List<Task> tasks;

  @override
  List<Object?> get props => [status, tasks];
  TasksState copyWith({TasksStatus? status, List<Task>? tasks}) {
    return TasksState(
        status: status ?? this.status, tasks: tasks ?? this.tasks);
  }

  @override
  String toString() {
    return 'TasksState(status:$status, tasks:$tasks)';
  }
}
