import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/theme/flex_theme_dark.dart';
import '../../core/theme/flex_theme_light.dart';
import '../../core/theme/theme_data_dark.dart';
import '../../core/theme/theme_data_light.dart';
import '../../core/theme_controller/theme_controller.dart';
import 'basic_app_home_screen.dart';
import 'features/dart/dart_screen.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({super.key, required this.controller});
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return MaterialApp(
          title: 'Basic App',
          debugShowCheckedModeBanner: false,
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
          onGenerateRoute: (settings) {
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
