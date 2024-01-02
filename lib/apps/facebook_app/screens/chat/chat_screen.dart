import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction <= 0) {
          if (context.canPop()) {
            context.pop();
          }
        }
      },
      onVerticalDragUpdate: (details) {},
      child: Scaffold(
        appBar: AppBar(title: const Text('채팅')),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red,
        ),
      ),
    );
  }
}
