import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseAppHomeScreen extends StatelessWidget {
  const FirebaseAppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Firebase App'),
          ),
        ],
      ),
    );
  }
}
