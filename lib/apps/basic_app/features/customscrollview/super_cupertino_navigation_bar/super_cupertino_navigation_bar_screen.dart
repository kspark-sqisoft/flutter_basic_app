import 'package:flutter/material.dart';

import 'page/home.dart';

class SuperCupertinoNavigationBarScreen extends StatelessWidget {
  const SuperCupertinoNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Home(title: 'Flutter Demo Home Page'),
    );
  }
}
