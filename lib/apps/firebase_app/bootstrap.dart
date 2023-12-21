import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../firebase_options.dart';
import 'features/api/apis.dart';
import 'firebase_app.dart' as firebase;

Future<void> bootstrap() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    log('androidInfo.version.sdkInt:${androidInfo.version.sdkInt}');

    //상단바, 하단바 없애기, 화면 로테이션이 가능한 풀스크린 앱
    //enter full-screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    //세로 고정
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((value) {
      Intl.defaultLocale =
          'ko-KR'; //Intl 관련된 defaultLocale, Intl 포멧 관련 한번에 KR로 설정

      _initializeFirebase();
      runApp(
        const firebase.FirebaseApp(),
      );
    });
    Logger.root.onRecord.listen((LogRecord rec) {
      debugPrint(
          '${rec.loggerName}>${rec.level.name}: ${rec.time}: ${rec.message}');
    });

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

@pragma('vm:entry-point')
Future<void> _firebasemessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  log('onBackgroundMessage remoteNotification - title:${notification?.title} body:${notification?.body}');
}

void _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebasemessagingBackgroundHandler);
  await APIs.setupInteractedMessage();
  await APIs.initLocalNotification();

  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  log('\nNotification Channel Result: $result');
}
