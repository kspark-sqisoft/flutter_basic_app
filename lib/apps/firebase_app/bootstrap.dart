import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../firebase_options.dart';
import 'firebase_app.dart' as firebase;

Future<void> bootstrap() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Logger.root.onRecord.listen((LogRecord rec) {
      debugPrint(
          '${rec.loggerName}>${rec.level.name}: ${rec.time}: ${rec.message}');
    });
    _initializeFirebase();
    runApp(
      const firebase.FirebaseApp(),
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

void _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
