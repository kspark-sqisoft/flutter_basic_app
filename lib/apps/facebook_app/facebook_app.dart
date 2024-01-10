import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

class FacebookApp extends ConsumerWidget {
  const FacebookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // set Status bar color in Android devices
      statusBarIconBrightness:
          Brightness.dark, // set Status bar icons color in Android devices
      statusBarBrightness: Brightness.dark, // set Status bar icon color in iOS
    ));
    return MaterialApp.router(
      title: 'Facebook App',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: <PointerDeviceKind>{
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      routerConfig: ref.watch(appRouterProvider),
      themeMode: ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
