import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:media_kit/media_kit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/todos/repositories/hive_todo_repository.dart';
import 'pages/todos/repositories/todo_repository_provider.dart';
import 'riverpod_app.dart';

Future<void> bootstrap() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Logger.root.onRecord.listen((LogRecord rec) {
      debugPrint(
          '${rec.loggerName}>${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log('androidInfo.version.baseOS:${androidInfo.version.baseOS}');
      log('androidInfo.version.codename:${androidInfo.version.codename}');
      log('androidInfo.version.release:${androidInfo.version.release}'); //안드로이드 버전
      log('androidInfo.version.sdkInt:${androidInfo.version.sdkInt}'); //API Level
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    }

    MediaKit.ensureInitialized();
    await dotenv.load(fileName: '.env');

    await Hive.initFlutter();
    await Hive.openBox('todos');

    final prefs = await SharedPreferences.getInstance();

    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          todoRepositoryProvider.overrideWithValue(HiveTodoRepository())
        ],
        child: const RiverpodApp(),
      ),
    );
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }, (error, stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
  });
}
