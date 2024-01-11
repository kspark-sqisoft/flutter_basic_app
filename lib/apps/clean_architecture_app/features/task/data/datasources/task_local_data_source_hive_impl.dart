import 'package:dartz/dartz.dart' hide Task;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/task.dart';
import '../models/task_model.dart';
import 'task_local_data_source.dart';

class TaskLocalDataSourceHiveImpl implements TaskLocalDataSource {
  final _kTasks = 'tasks';

  @override
  Future<bool> initDb() async {
    try {
      //final appDocumentDir = await getApplicationDocumentsDirectory();
      //print('appDocumentDir.path:${appDocumentDir.path}');
      //Hive.init(appDocumentDir.path);
      await Hive.initFlutter();
      Hive.registerAdapter(TaskAdapter());

      await Hive.openBox<Task>(_kTasks);
      return true;
    } catch (e) {
      print(e);
      throw ConnectionException();
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final tasksBox = Hive.box<Task>(_kTasks);
      final result = tasksBox.values
          .map<TaskModel>((e) => TaskModel(
              id: e.id,
              title: e.title,
              description: e.description,
              isDone: e.isDone))
          .toList();
      return result;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> addTask(TaskModel task) async {
    print('add $task');
    try {
      final tasksBox = Hive.box<Task>(_kTasks);

      final convertedTask = Task(
          id: task.id,
          title: task.title,
          description: task.description,
          isDone: task.isDone);

      //await tasksBox.add(convertedTask);
      await tasksBox.put(convertedTask.id, convertedTask);
      return Future.value(unit);
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<Unit> deleteTasks() async {
    final tasksBox = Hive.box<Task>(_kTasks);
    await tasksBox.clear();
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteTask(TaskModel task) async {
    try {
      final tasksBox = Hive.box<Task>(_kTasks);

      //await tasksBox.clear();

      final convertedTask = Task(
          id: task.id,
          title: task.title,
          description: task.description,
          isDone: task.isDone);

      await tasksBox.delete(convertedTask.id);
      return Future.value(unit);
    } catch (_) {
      throw ConnectionException();
    }
  }
}
