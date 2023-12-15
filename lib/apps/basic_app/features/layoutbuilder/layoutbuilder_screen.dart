import 'package:flutter/material.dart';

class LayoutBuilderScreen extends StatelessWidget {
  const LayoutBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LayoutBuilder')),
      body: const Responsive(
        desktop: Desktop(),
        mobile: Mobile(),
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.desktop,
    required this.mobile,
  });
  final Widget desktop;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({super.key});

  @override
  Widget build(BuildContext context) {
    print('Desktop build');
    return Container(
      color: Colors.red,
      child: const Center(
          child: Text('DESKTOP',
              style: TextStyle(color: Colors.white, fontSize: 30))),
    );
  }
}

class Mobile extends StatelessWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    print('Mobile build');
    return Container(
      color: Colors.green,
      child: const Center(
          child: Text(
        'MOBILE',
        style: TextStyle(color: Colors.white, fontSize: 30),
      )),
    );
  }
}
