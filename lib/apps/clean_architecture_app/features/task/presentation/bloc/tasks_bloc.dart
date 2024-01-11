import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/delete_tasks.dart';
import '../../domain/usecases/get_tasks.dart';
import 'tasks_event.dart';
import 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;
  final DeleteTasks deleteTasks;
  TasksBloc({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
    required this.deleteTasks,
  }) : super(const TasksState()) {
    print('TasksBloc constructor');
    on<TasksFetched>(_onTasksFetched);
    on<TasksAdded>(_onTasksAdded);
    on<TasksDeleted>(_onTasksDeleted);
    on<TasksAllDeleted>(_onTasksAllDeleted);
  }

  FutureOr<void> _onTasksFetched(
      TasksFetched event, Emitter<TasksState> emit) async {
    print('TasksBloc _onTasksFetched');
    emit(state.copyWith(status: TasksStatus.loading));
    final failureOrTasks = await getTasks(NoParams());
    emit(
      failureOrTasks.fold(
        (failure) {
          return state.copyWith(
            status: TasksStatus.failure,
          );
        },
        (tasks) {
          return state.copyWith(
            status: TasksStatus.loaded,
            tasks: tasks,
          );
        },
      ),
    );
  }

  FutureOr<void> _onTasksAdded(
      TasksAdded event, Emitter<TasksState> emit) async {
    final failureOrUnit = await addTask(AddTaskParams(task: event.task));
    failureOrUnit.fold((fail) {}, (unit) {
      add(TasksFetched());
    });
  }

  FutureOr<void> _onTasksDeleted(
      TasksDeleted event, Emitter<TasksState> emit) async {
    final failureOrUnit = await deleteTask(DeleteTaskParams(task: event.task));
    failureOrUnit.fold((fail) {}, (unit) {
      add(TasksFetched());
    });
  }

  FutureOr<void> _onTasksAllDeleted(
      TasksAllDeleted event, Emitter<TasksState> emit) async {
    final failureOrUnit = await deleteTasks(NoParams());
    failureOrUnit.fold((fail) {}, (unit) {
      add(TasksFetched());
    });
  }
}
