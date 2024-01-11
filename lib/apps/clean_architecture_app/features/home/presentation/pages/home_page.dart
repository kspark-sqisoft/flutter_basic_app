import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Clean Architecture',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed(AppRouter.productsNamed);
                },
                child: const Text('products')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed(AppRouter.tasksNamed);
                },
                child: const Text('tasks')),
          ],
        ),
      ),
    );
  }
}
