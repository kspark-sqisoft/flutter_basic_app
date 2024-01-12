import 'package:flutter/material.dart';

class AnimationBasicScreen extends StatelessWidget {
  const AnimationBasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Basic')),
      body: const LogoApp(),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<double> alphaAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    //curve 추가
    final Animation<double> curve = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1, curve: Curves.fastOutSlowIn),
    ); //Interval은 0-1  전체 애니메이션 시간의 반(0.5)에서 끝(1) 까지, 여러 애니매이션이 있을 경우 순서 시간 조정 가능
    //curve 추가 않할 경우 animate(컨트롤러)
    //animation = Tween<double>(begin: 0, end: 300).animate(controller)
    sizeAnimation = Tween<double>(begin: 0, end: 300).animate(curve)
      ..addListener(() {
        setState(() {}); //있어야 한다.
      })
      ..addStatusListener((status) {
        print('$status');
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    alphaAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlphaTransition(
      animation: alphaAnimation,
      child: GrowTransition(
        animation: sizeAnimation,
        child: const FlutterLogo(),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {super.key, required this.child, required this.animation});
  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => SizedBox(
        width: animation.value,
        height: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}

class AlphaTransition extends StatelessWidget {
  const AlphaTransition(
      {super.key, required this.child, required this.animation});
  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: animation.value,
        child: child,
      ),
      child: child,
    );
  }
}
