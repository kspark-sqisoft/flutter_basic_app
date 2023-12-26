import 'package:flutter/material.dart';

class AppleTVScreen extends StatelessWidget {
  const AppleTVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Apple TV+',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }
}
