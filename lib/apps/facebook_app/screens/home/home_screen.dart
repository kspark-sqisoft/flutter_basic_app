import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: Colors.white,
          title: Text(
            'facebook',
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 1000),
        )
      ],
    );
  }
}
