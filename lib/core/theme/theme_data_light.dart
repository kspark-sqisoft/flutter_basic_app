import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme_const/app.dart';
import '../theme_controller/theme_controller.dart';
import '../theme_model/visual_density_enum.dart';
import 'code_theme.dart';
import 'flex_theme_light.dart';
import 'topic_theme.dart';

ThemeData themeDataLight(ThemeController controller) {
  final ColorScheme colorScheme =
      flexColorSchemeLight(controller, Colors.black).toScheme;

  return ThemeData(
    brightness: Brightness.light,
    fontFamily: controller.useAppFont ? App.font : null,
    textTheme: controller.useAppFont ? App.textTheme : null,
    primaryTextTheme: controller.useAppFont ? App.textTheme : null,
    // The ColorScheme we get here is the same one you can also generate
    // Copy/paste code for in the ThemesPlayground UI, and it represent the
    // effective scheme in the Playground app.
    colorScheme: colorScheme,
    // Use the colorScheme to make a nicer light theme.
    primaryColor: colorScheme.primary,
    canvasColor: colorScheme.background,
    scaffoldBackgroundColor: colorScheme.background,
    cardColor: colorScheme.surface,
    dividerColor: colorScheme.outlineVariant,
    dialogBackgroundColor: colorScheme.background,
    indicatorColor: colorScheme.onPrimary,

    // To our ThemeData we also apply the visual density, typography, selected
    // platform and useMaterial3 flag, that we used in FlexColorScheme created
    // ThemeData. We do this so created theme will be using the same features
    // in the Playground app
    visualDensity: controller.usedVisualDensity?.setting(controller.platform) ??
        VisualDensityEnum.platform.setting(controller.platform),
    platform: controller.platform,
    useMaterial3: controller.useMaterial3,
    typography: controller.useMaterial3
        ? Typography.material2021(
            platform: controller.platform ?? defaultTargetPlatform)
        : Typography.material2018(
            platform: controller.platform ?? defaultTargetPlatform),
    // Add a custom theme extension with light mode code highlight colors and
    // light mode topic colors.
    extensions: <ThemeExtension<dynamic>>{
      CodeTheme.harmonized(colorScheme.surfaceTint, Brightness.light),
      TopicTheme.harmonized(colorScheme.surfaceTint, Brightness.light),
    },

    // See: https://github.com/flutter/flutter/issues/123507
    // This is a fix to avoid the Flutter Drawer width bug and overflow bug
    // when it animates via zero width in null default to widget default.
    drawerTheme: const DrawerThemeData(width: 304),
  );
}
