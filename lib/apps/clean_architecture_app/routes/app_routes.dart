import 'package:go_router/go_router.dart';

import '../features/home/presentation/pages/home_page.dart';
import '../features/product/presentation/pages/products_page.dart';
import '../features/task/presentation/pages/tasks_page.dart';
import 'screens/not_found_screen.dart';

class AppRouter {
  static const home = '/';
  static const products = 'products';
  static const tasks = 'tasks';

  static const homeNamed = 'home';
  static const productsNamed = 'products';
  static const tasksNamed = 'tasks';

  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
          path: home,
          name: homeNamed,
          pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
          routes: [
            GoRoute(
              path: products,
              name: productsNamed,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProductsPage(),
              ),
            ),
            GoRoute(
              path: tasks,
              name: tasksNamed,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TasksPage(),
              ),
            ),
          ])
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
