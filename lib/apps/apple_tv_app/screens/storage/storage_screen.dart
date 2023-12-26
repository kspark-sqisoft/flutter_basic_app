import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        '저장소',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }
}
