import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero$index',
      child: Scaffold(
        appBar: AppBar(title: const Text('Story')),
      ),
    );
  }
}
