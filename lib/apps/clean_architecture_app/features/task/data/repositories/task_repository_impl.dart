import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource taskLocalDataSource;
  TaskRepositoryImpl({required this.taskLocalDataSource});

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final response = await taskLocalDataSource.getTasks();
      return Right(response);
    } on NoDataException {
      return const Left(NoDataFailure('no data'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addTask(Task task) async {
    try {
      final response = await taskLocalDataSource.addTask(TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          isDone: task.isDone));
      return Right(response);
    } on ConnectionException {
      return const Left(DatabaseFailure('database add fail'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(Task task) async {
    try {
      final response = await taskLocalDataSource.deleteTask(TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          isDone: task.isDone));
      return Right(response);
    } on ConnectionException {
      return const Left(DatabaseFailure('database delete fail'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTasks() async {
    try {
      final response = await taskLocalDataSource.deleteTasks();
      return Right(response);
    } on ConnectionException {
      return const Left(DatabaseFailure('database delete all fail'));
    }
  }
}
