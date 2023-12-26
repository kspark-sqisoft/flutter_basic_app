import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        '스토어',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }
}
