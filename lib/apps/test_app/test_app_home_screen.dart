import 'package:flutter/material.dart';

class TestAppHomeScreen extends StatelessWidget {
  const TestAppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Test App'),
          ),
        ],
      ),
    );
  }
}
