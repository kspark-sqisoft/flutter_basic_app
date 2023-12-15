import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class DragScrollBehavior extends MaterialScrollBehavior {
  const DragScrollBehavior();
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

/// AppScrollBehavior with no implicit scrollbars on any platform.
///
/// Useful with nested listviews that need to share scroll controller
@immutable
class NoScrollbarBehavior extends DragScrollBehavior {
  const NoScrollbarBehavior();
  // Override for no scrollbars.
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

/// Another alternative custom scroll behavior class.
/// Using the Apple iOS bouncing scroll and over stretch.
///
/// Currently not used in these apps, but experimented with it, for some other
/// type of app it is quite cool.
@immutable
class AppleScrollBehavior extends ScrollBehavior {
  const AppleScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
