import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screens/chat/chat_screen.dart';
import '../screens/home/new_feed_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../components/scaffold_with_bottom_navigation_bar.dart';
import '../screens/friend/friend_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/story/story_screen.dart';
import '../screens/video/video_screen.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _sectionHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionHomeNav');
final GlobalKey<NavigatorState> _sectionVideoNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionVideoNav');
final GlobalKey<NavigatorState> _sectionFriendNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionFriendNav');
final GlobalKey<NavigatorState> _sectionProfileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionProfileNav');
final GlobalKey<NavigatorState> _sectionNotificationNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionProfileNav');
final GlobalKey<NavigatorState> _sectionMenuNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionMenuNav');

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/newfeed',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const NewFeedScreen(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
                Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: '/story/:id',
        builder: (context, state) => HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: StoryScreen(
              index: int.parse(state.pathParameters['id']!),
            )),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithBottomNavigationBar(
          navigationShell: navigationShell,
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _sectionHomeNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionVideoNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/video',
                builder: (context, state) => const VideoScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionFriendNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/friend',
                builder: (context, state) => const FriendScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionProfileNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionNotificationNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/notification',
                builder: (context, state) => const NotificationScreen(),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sectionMenuNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                  path: '/menu',
                  pageBuilder: (context, state) => CustomTransitionPage(
                        child: const MenuScreen(),
                        transitionDuration: const Duration(milliseconds: 200),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                SlideTransition(
                          position: animation.drive(Tween<Offset>(
                              begin: const Offset(0, 1), end: Offset.zero)),
                          child: child,
                        ),
                      ))
            ],
          ),
        ],
      ),
    ],
  );
}
