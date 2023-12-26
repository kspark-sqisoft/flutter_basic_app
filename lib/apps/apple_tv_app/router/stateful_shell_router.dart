import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../components/scaffold_with_navbar.dart';
import '../screens/appletv/appletv_screen.dart';
import '../screens/home/apple_tv_home_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/storage/storage_screen.dart';
import '../screens/store/store_screen.dart';

part 'stateful_shell_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionHomeNav');
final GlobalKey<NavigatorState> _sectionAppleTVNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionAppleTVNav');
final GlobalKey<NavigatorState> _sectionStoreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionStoreNav');
final GlobalKey<NavigatorState> _sectionStorageNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionStorageNav');
final GlobalKey<NavigatorState> _sectionSearchNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionSearchNav');

@riverpod
GoRouter statefulShellRouter(StatefulShellRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ScaffoldWithNavbar(
          navigationShell: navigationShell,
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _sectionHomeNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (context, state) => const AppleTVHomeScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionAppleTVNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/appletv',
                builder: (context, state) => const AppleTVScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionStoreNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/store',
                builder: (context, state) => const StoreScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionStorageNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/storage',
                builder: (context, state) => const StorageScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionSearchNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              )
            ],
          ),
        ],
      ),
    ],
  );
}
