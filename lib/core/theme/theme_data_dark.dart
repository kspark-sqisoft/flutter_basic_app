import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme_const/app.dart';
import '../theme_controller/theme_controller.dart';
import '../theme_model/visual_density_enum.dart';
import 'code_theme.dart';
import 'flex_theme_dark.dart';
import 'topic_theme.dart';

ThemeData themeDataDark(ThemeController controller) {
  final ColorScheme colorScheme =
      flexColorSchemeDark(controller, Colors.black).toScheme;

  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: controller.useAppFont ? App.font : null,
    textTheme: controller.useAppFont ? App.textTheme : null,
    primaryTextTheme: controller.useAppFont ? App.textTheme : null,
    // The ColorScheme we get here is the same one you can also generate
    // Copy/paste code for in the ThemesPlayground UI, and it represent the
    // effective scheme in the Playground app.
    colorScheme: colorScheme,
    // Use the colorScheme to make a nicer light theme.
    primaryColor: colorScheme.surface,
    canvasColor: colorScheme.background,
    scaffoldBackgroundColor: colorScheme.background,
    cardColor: colorScheme.surface,
    dividerColor: colorScheme.outlineVariant,
    dialogBackgroundColor: colorScheme.background,
    indicatorColor: colorScheme.onSurface,
    // To our ThemeData we also apply the visual density, typography, selected
    // platform and useMaterial3 flag, that we used in FlexColorScheme created
    // ThemeData. We do this so created theme will be using the same features
    // in the Playground app.
    visualDensity: controller.usedVisualDensity?.setting(controller.platform) ??
        VisualDensityEnum.platform.setting(controller.platform),
    platform: controller.platform,
    useMaterial3: controller.useMaterial3,
    applyElevationOverlayColor: true,
    typography: controller.useMaterial3
        ? Typography.material2021(
            platform: controller.platform ?? defaultTargetPlatform)
        : Typography.material2018(
            platform: controller.platform ?? defaultTargetPlatform),
    // Add a custom theme extension with light mode code highlight colors and
    // dark mode topic colors.
    extensions: <ThemeExtension<dynamic>>{
      CodeTheme.harmonized(colorScheme.surfaceTint, Brightness.dark),
      TopicTheme.harmonized(colorScheme.surfaceTint, Brightness.dark),
    },

    // See: https://github.com/flutter/flutter/issues/123507
    // This is fix to avoid the Flutter Drawer width bug and overflow bug
    // when it animates via zero width in null default to widget default.
    drawerTheme: const DrawerThemeData(width: 304),
  );
}
