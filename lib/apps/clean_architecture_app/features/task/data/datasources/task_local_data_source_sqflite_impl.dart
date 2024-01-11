import 'dart:io';

import 'package:dartz/dartz.dart' hide Task;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../core/error/exceptions.dart';
import '../models/task_model.dart';
import 'task_local_data_source.dart';

//윈도우는 안된다.
class TaskLocalDataSourceSqfliteImpl implements TaskLocalDataSource {
  late Database _db;
  final _kDbName = 'sqflite_tasks.db';
  final _kTasksTb = 'tasks';

  @override
  Future<bool> initDb() async {
    try {
      final dbFolder = await getDatabasesPath();
      print('dbFolder:$dbFolder');
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, _kDbName);
      _db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await _initTasksTable(db);
        },
      );
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  Future<void> _initTasksTable(Database db) async {
    await db.execute('''
          CREATE TABLE $_kTasksTb(
          id TEXT,
          title TEXT,
          description TEXT,
          isDone INTEGER
          )
        ''');
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final json = await _db.rawQuery('SELECT * FROM $_kTasksTb');
    return json.map<TaskModel>((e) => TaskModel.fromJson(e)).toList();
  }

  @override
  Future<Unit> addTask(TaskModel task) async {
    try {
      await _db.transaction(
        (txn) async {
          await txn.rawInsert('''
          INSERT INTO $_kTasksTb 
          (
          id,
          title,
          description,
          isDone
          )
          VALUES
            (
              "${task.id}",
              "${task.title}",
              "${task.description}",
              "${task.isDone}"
            )''');
        },
      );
      // success inserted data
      return Future.value(unit);
    } catch (e) {
      throw ConnectionException();
    }
  }

  @override
  Future<Unit> deleteTask(TaskModel task) async {
    try {
      await _db.rawDelete('''
        DELETE FROM $_kTasksTb
        WHERE id = '${task.id}'
      ''');
      return Future.value(unit);
    } catch (e) {
      throw ConnectionException();
    }
  }

  @override
  Future<Unit> deleteTasks() async {
    try {
      await _db.rawDelete('''
        DELETE FROM $_kTasksTb
      ''');
      return Future.value(unit);
    } catch (e) {
      throw ConnectionException();
    }
  }
}
