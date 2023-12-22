import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/theme_provider.dart';
import 'riverpod_app_home_screen.dart';
import 'router/router_state_full_shell_provider.dart';

part 'riverpod_app.g.dart';
part 'riverpod_app.freezed.dart';

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

enum ChangeRouteType {
  going,
  restoring,
}

@freezed
class ChangeRouteState with _$ChangeRouteState {
  const factory ChangeRouteState({
    @Default(ChangeRouteType.restoring) ChangeRouteType routeType,
    @Default('') String routeName,
  }) = _ChangeRouteState;
}

@riverpod
class ChangeRoute extends _$ChangeRoute {
  @override
  ChangeRouteState build() {
    return const ChangeRouteState();
  }

  void changeRoute(
      {required ChangeRouteType changeRouteType, required String routeName}) {
    state = ChangeRouteState(
      routeType: changeRouteType,
      routeName: routeName,
    );
  }
}

class RiverpodApp extends ConsumerStatefulWidget {
  const RiverpodApp({super.key});

  @override
  ConsumerState<RiverpodApp> createState() => _RiverpodAppState();
}

class _RiverpodAppState extends ConsumerState<RiverpodApp> {
  String lastLocation = '';

  void changeRoute() {
    GoRouter router = ref.read(routeStateFullShellProvider);
    print(
        '=====>${router.routerDelegate.currentConfiguration.last.matchedLocation}');
    final currentLocation =
        router.routerDelegate.currentConfiguration.last.matchedLocation;
    if (currentLocation == lastLocation) {
      //같은 페이지 (무언가 초기화)
      print('going==============');
      ref.read(changeRouteProvider.notifier).changeRoute(
          changeRouteType: ChangeRouteType.going, routeName: currentLocation);
    } else {
      //다른 페이지 이동시 (유지)
      print('restoring=============');
      ref.read(changeRouteProvider.notifier).changeRoute(
          changeRouteType: ChangeRouteType.restoring,
          routeName: currentLocation);
    }
    lastLocation =
        router.routerDelegate.currentConfiguration.last.matchedLocation;
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);
    final router = ref.watch(routeStateFullShellProvider);
    router.routeInformationProvider.removeListener(changeRoute);
    router.routeInformationProvider.addListener(changeRoute);
    return MaterialApp.router(
      title: 'Riverpod App',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: <PointerDeviceKind>{
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      theme: switch (currentTheme) {
        LightTheme() => ThemeData.light(useMaterial3: true),
        DarkTheme() => ThemeData.dark(useMaterial3: true),
      },
      routerConfig: router,
    );
  }
}
