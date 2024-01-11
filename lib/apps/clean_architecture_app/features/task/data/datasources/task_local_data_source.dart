import 'package:dartz/dartz.dart';

import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<bool> initDb();
  Future<List<TaskModel>> getTasks();
  Future<Unit> addTask(TaskModel task);
  Future<Unit> deleteTask(TaskModel task);
  Future<Unit> deleteTasks();
}
