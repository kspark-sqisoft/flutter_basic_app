import 'package:flutter/material.dart';

class RiverpodAppHomeScreen extends StatefulWidget {
  const RiverpodAppHomeScreen({super.key});

  @override
  State<RiverpodAppHomeScreen> createState() => _RiverpodAppHomeScreenState();
}

class _RiverpodAppHomeScreenState extends State<RiverpodAppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Riverpod App'),
          ),
        ],
      ),
    );
  }
}
