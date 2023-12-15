import 'package:flutter/material.dart';

class BlocAppHomeScreen extends StatelessWidget {
  const BlocAppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Bloc App'),
          ),
        ],
      ),
    );
  }
}
