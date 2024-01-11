import 'package:equatable/equatable.dart';

import '../../domain/entities/task.dart';

sealed class TasksEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class TasksFetched extends TasksEvent {}

final class TasksAdded extends TasksEvent {
  final Task task;
  TasksAdded({required this.task});
}

final class TasksDeleted extends TasksEvent {
  final Task task;
  TasksDeleted({required this.task});
}

final class TasksAllDeleted extends TasksEvent {}
