import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/ffi/ffi.dart';

import '../../core/theme/flex_theme_dark.dart';
import '../../core/theme/flex_theme_light.dart';
import '../../core/theme/theme_data_dark.dart';
import '../../core/theme/theme_data_light.dart';
import '../../core/theme_const/app_color.dart';
import '../../core/theme_controller/theme_controller.dart';
import 'basic_app_home_screen.dart';
import 'features/dart/dart_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class BasicApp extends StatelessWidget {
  const BasicApp({super.key, required this.controller});
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < FlexColor.schemesList.length; i++) {
      //log('FlexColor.schemesList[$i].name ${FlexColor.schemesList[i].name}');
    }
    //AppColor.customSchemes 에서 앞에 추가 [Example Midnight, Example Greens, Example Red & Blue]
    log('controller.themeMode:${controller.themeMode}');
    log('controller.schemeIndex:${controller.schemeIndex}');
    log('selected AppColor.customSchemes[${controller.schemeIndex}].name : ${AppColor.customSchemes[controller.schemeIndex].name}');
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return MaterialApp(
          title: 'Basic App',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: <PointerDeviceKind>{
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          theme: controller.useFlexColorScheme
              ? flexThemeLight(controller)
              : themeDataLight(controller),
          darkTheme: controller.useFlexColorScheme
              ? flexThemeDark(controller)
              : themeDataDark(controller),
          themeMode: controller.themeMode,
          initialRoute: BasicAppHomeScreen.routeName,
          onGenerateRoute: (RouteSettings settings) {
            return switch (settings.name) {
              BasicAppHomeScreen.routeName => MaterialPageRoute(
                  builder: (context) => BasicAppHomeScreen(
                    controller: controller,
                  ),
                ),
              DartScreen.routeName => MaterialPageRoute(
                  builder: (context) => const DartScreen(),
                ),
              _ => MaterialPageRoute(
                  builder: (context) => const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  ),
                )
            };
          },
        );
      },
    );
  }
}
