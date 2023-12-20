import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//아직 사용 안함 더 큰 앱 만들때
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
