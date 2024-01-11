import 'package:dartz/dartz.dart';

import 'package:sembast/sembast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';

import '../../../../core/error/exceptions.dart';
import '../models/task_model.dart';
import 'task_local_data_source.dart';

class TaskLocalDataSourceSembastImpl implements TaskLocalDataSource {
  final _kDbFileName = 'sembast_tasks.db';
  final _kTasks = 'tasks';

  late Database _database;
  late StoreRef<Object, Map<String, dynamic>> _tasksStore;

  @override
  Future<bool> initDb() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _kDbFileName);
      _database = await databaseFactoryIo.openDatabase(dbPath);
      _tasksStore = stringMapStoreFactory
          .store(_kTasks); //intMapStoreFactory, stringMapStoreFactory
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final recordSnapshots = await _tasksStore.find(_database);

      final response = recordSnapshots
          .map<TaskModel>((e) => TaskModel.fromJson(e.value))
          .toList(growable: false);
      return response;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> addTask(TaskModel task) async {
    try {
      print('add $task');
      await _tasksStore.record(task.id).put(_database, task.toJson());

      return Future.value(unit);
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<Unit> deleteTask(TaskModel task) async {
    try {
      print('delete $task');
      await _tasksStore.record(task.id).delete(_database);

      return Future.value(unit);
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<Unit> deleteTasks() async {
    try {
      await _tasksStore.delete(_database);
      return Future.value(unit);
    } catch (_) {
      throw ConnectionException();
    }
  }
}
