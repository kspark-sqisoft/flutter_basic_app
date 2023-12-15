import 'package:flutter/material.dart';

class CleanArchitectureAppHomeScreen extends StatelessWidget {
  const CleanArchitectureAppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('CleanArchitecture App'),
          ),
        ],
      ),
    );
  }
}
