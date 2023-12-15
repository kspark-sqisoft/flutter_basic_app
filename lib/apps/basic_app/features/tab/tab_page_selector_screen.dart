import 'dart:async';

import 'package:flutter/material.dart';

class TabPageSelectorScreen extends StatefulWidget {
  const TabPageSelectorScreen({super.key});

  @override
  State<TabPageSelectorScreen> createState() => _TabPageSelectorScreenState();
}

class _TabPageSelectorScreenState extends State<TabPageSelectorScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  static const _colors = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.purple,
    Colors.pink,
  ];
  int _index = 0;
  late final Timer _timer;

  void _circulate() {
    (_index != _colors.length - 1) ? _index++ : _index = 0;
    _controller.animateTo(_index, duration: const Duration(milliseconds: 500));
    setState(() {});
  }

  @override
  void initState() {
    _controller = TabController(
      length: _colors.length,
      initialIndex: _index,
      vsync: this,
    );
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _circulate(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabPageSelector'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: _colors[_controller.index],
          ),
          Image.network(
            "https://picsum.photos/1920/1080?random=${_controller.index}",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 20,
            child: TabPageSelector(
              controller: _controller,
              color: Colors.black38,
              selectedColor: Colors.white30,
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonBar(
        children: [
          CustomFab(
            icon: Icons.navigate_next,
            onPressed: _circulate,
            heroTag: 'next',
          ),
          CustomFab(
            icon: Icons.stop,
            onPressed: _timer.cancel,
            heroTag: 'stop',
          ),
        ],
      ),
    );
  }
}

class CustomFab extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String heroTag;

  const CustomFab({
    Key? key,
    required this.icon,
    this.onPressed,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: Colors.black26,
      hoverElevation: 0,
      elevation: 0,
      child: Icon(icon),
    );
  }
}
