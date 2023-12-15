import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: const SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  '암묵적 애니메이션(Implicit Animation)',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                AnimatedOpacityWidget(),
              ],
            ),
            Column(
              children: [
                Text(
                  '명시적 애니메이션(Explicit Animation)',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('1. 빌트인 위젯 사용'),
                FadeTransitionWidget(),
                SizedBox(
                  height: 50,
                ),
                Text('2. AnimatedBuilder 사용'),
                SizedBox(
                  height: 40,
                ),
                RotateAnimationWidget(),
                SizedBox(
                  height: 50,
                ),
                Text('3. Tween 사용(범위 바꾸기)(case1, case2)'),
                SizedBox(
                  height: 40,
                ),
                TranslateAnimationWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedOpacityWidget extends StatefulWidget {
  const AnimatedOpacityWidget({super.key});

  @override
  State<AnimatedOpacityWidget> createState() => _AnimatedOpacityWidgetState();
}

class _AnimatedOpacityWidgetState extends State<AnimatedOpacityWidget> {
  bool selected = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.amber,
        child: AnimatedOpacity(
          opacity: selected ? 1 : 0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInToLinear,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class FadeTransitionWidget extends StatefulWidget {
  const FadeTransitionWidget({super.key});

  @override
  State<FadeTransitionWidget> createState() => _FadeTransitionWidgetState();
}

class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;
  bool selected = true;

  @override
  void initState() {
    //AnimationController 범위는 0~1
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInToLinear,
    );
    if (selected) {
      _controller.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
        if (selected) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.amber,
        child: FadeTransition(
          opacity: _animation,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class RotateAnimationWidget extends StatefulWidget {
  const RotateAnimationWidget({super.key});

  @override
  State<RotateAnimationWidget> createState() => _RotateAnimationWidgetState();
}

class _RotateAnimationWidgetState extends State<RotateAnimationWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
          width: 200,
          height: 200,
          color: Colors.lightGreen,
          child: const FlutterLogo()),
      builder: (context, child) => Transform.rotate(
        angle: _controller.value * 2.0 * math.pi, //Tween 사용 전 곱해서
        child: child,
      ),
    );
  }
}

class TranslateAnimationWidget extends StatefulWidget {
  const TranslateAnimationWidget({super.key});

  @override
  State<TranslateAnimationWidget> createState() =>
      _TranslateAnimationWidgetState();
}

class _TranslateAnimationWidgetState extends State<TranslateAnimationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  /**
   * Tween 범위 변경
   */
  //Case1 방법으로 작성
  late final Animation _rotateAnimation = _controller.drive(
    Tween<double>(begin: 0, end: math.pi * 2),
  );
  //Case2 방법으로 작성
  late final Animation _scaleAnimation =
      Tween<double>(begin: 0.0, end: 2).animate(_controller);
  late final Animation _translateAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(0, 400),
  ).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_TranslateAnimationWidgetState build');
    return Column(
      children: [
        AnimatedBuilder(
          animation: _controller,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.lightGreen,
            child: const FlutterLogo(),
          ),
          builder: (context, child) => Transform.translate(
            offset: _translateAnimation.value,
            child: child,
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.lightBlue,
            child: const FlutterLogo(),
          ),
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            child: const FlutterLogo(),
          ),
          builder: (context, child) => Transform.rotate(
            angle: _rotateAnimation.value,
            child: child,
          ),
        ),
      ],
    );
  }
}
