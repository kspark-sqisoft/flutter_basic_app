import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

import '../../../../core/widgets/code.dart';

class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyAnimatedIcon(),
                SizedBox(
                  width: 20,
                ),
                Code('''
AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: _controller,
        size: 100,
      )
''')
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 300, height: 500, child: MyStepper()),
                SizedBox(
                  width: 20,
                ),
                Code('''
Stepper(
      steps: [
        Step(
          isActive: _currentStep == 0,
          title: const Text('Step 1'),
          content: const Text(
            'Information for step 1',
            style: TextStyle(color: Colors.red),
          ),
        ),
        Step(
          isActive: _currentStep == 1,
          title: const Text('Step 2'),
          content: const Text(
            'Information for step 2',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Step(
          isActive: _currentStep == 2,
          title: const Text('Step 3'),
          content: const Text(
            'Information for step 3',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
      onStepTapped: (value) {
        setState(() {
          _currentStep = value;
        });
      },
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep != 2) {
          setState(() {
            _currentStep++;
          });
        }
      },
      onStepCancel: () {
        if (_currentStep != 0) {
          setState(() {
            _currentStep--;
          });
        }
      },
    );
''')
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 300,
                    height: 100,
                    child: MyCupertinoSlidingSegmentedControl()),
                SizedBox(
                  width: 20,
                ),
                Code('''
CupertinoSlidingSegmentedControl(
      children: const {
        0: Text('Text 0'),
        1: Text('Text 1'),
        2: Text('Text 2'),
      },
      groupValue: _slidingIndex,
      onValueChanged: (value) {
        setState(() {
          _slidingIndex = value;
        });
      },
    );
''')
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent, //중요
                    child: InkWell(
                      splashColor: Colors.red,
                      borderRadius: BorderRadius.circular(10), //중요
                      onTap: () {},
                      child: const SizedBox(
                        width: 200,
                        height: 200,
                        child: Center(child: Text('InkWell')),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Code('''
Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent, //중요
                    child: InkWell(
                      splashColor: Colors.red,
                      borderRadius: BorderRadius.circular(10), //중요
                      onTap: () {},
                      child: const SizedBox(
                        width: 200,
                        height: 200,
                        child: Center(child: Text('InkWell')),
                      ),
                    ),
                  ),
                )
''')
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    MaskImage(
                      isOpen: true,
                      imgPath: 'assets/images/facebook/user4.jpg',
                    ),
                    MaskImage(
                      isOpen: false,
                      imgPath: 'assets/images/facebook/user5.jpg',
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Code('''
WidgetMask(
          blendMode: BlendMode.srcIn,
          childSaveLayer: true,
          mask: Image.asset(
            widget.imgPath,
            width: 400,
            height: 400,
            fit: BoxFit.cover,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastEaseInToSlowEaseOut,
            width: _isOpen ? 400 : 0,
            height: 400,
            child: Container(
              color: Colors.white,
            ),
          ),
        )
''')
              ],
            )
          ],
        ),
      )),
    );
  }
}

//AnimatedIcon
class MyAnimatedIcon extends StatefulWidget {
  const MyAnimatedIcon({super.key});

  @override
  State<MyAnimatedIcon> createState() => _MyAnimatedIconState();
}

class _MyAnimatedIconState extends State<MyAnimatedIcon>
    with TickerProviderStateMixin {
  bool _isPlay = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
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
        if (_isPlay == false) {
          _controller.forward();
          _isPlay = true;
        } else {
          _controller.reverse();
          _isPlay = false;
        }
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: _controller,
        size: 100,
        color: Colors.lightBlue,
      ),
    );
  }
}

//Stepper
class MyStepper extends StatefulWidget {
  const MyStepper({super.key});

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: [
        Step(
          isActive: _currentStep == 0,
          title: const Text('Step 1'),
          content: const Text(
            'Information for step 1',
            style: TextStyle(color: Colors.red),
          ),
        ),
        Step(
          isActive: _currentStep == 1,
          title: const Text('Step 2'),
          content: const Text(
            'Information for step 2',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Step(
          isActive: _currentStep == 2,
          title: const Text('Step 3'),
          content: const Text(
            'Information for step 3',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
      onStepTapped: (value) {
        setState(() {
          _currentStep = value;
        });
      },
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep != 2) {
          setState(() {
            _currentStep++;
          });
        }
      },
      onStepCancel: () {
        if (_currentStep != 0) {
          setState(() {
            _currentStep--;
          });
        }
      },
    );
  }
}

class MyCupertinoSlidingSegmentedControl extends StatefulWidget {
  const MyCupertinoSlidingSegmentedControl({super.key});

  @override
  State<MyCupertinoSlidingSegmentedControl> createState() =>
      _MyCupertinoSlidingSegmentedControlState();
}

class _MyCupertinoSlidingSegmentedControlState
    extends State<MyCupertinoSlidingSegmentedControl> {
  int? _slidingIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      children: const {
        0: Text('Text 0'),
        1: Text('Text 1'),
        2: Text('Text 2'),
      },
      groupValue: _slidingIndex,
      onValueChanged: (value) {
        setState(() {
          _slidingIndex = value;
        });
      },
    );
  }
}

class MaskImage extends StatefulWidget {
  const MaskImage({
    super.key,
    required this.imgPath,
    this.isOpen = false,
  });
  final String imgPath;
  final bool isOpen;

  @override
  State<MaskImage> createState() => _MaskImageState();
}

class _MaskImageState extends State<MaskImage> {
  bool _isOpen = false;

  @override
  void initState() {
    _isOpen = widget.isOpen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOpen = !_isOpen;
        });
      },
      child: Stack(children: [
        Container(
          width: 400,
          height: 400,
          color: Colors.red.withOpacity(0),
        ),
        WidgetMask(
          blendMode: BlendMode.srcIn,
          childSaveLayer: true,
          mask: Image.asset(
            widget.imgPath,
            width: 400,
            height: 400,
            fit: BoxFit.cover,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastEaseInToSlowEaseOut,
            width: _isOpen ? 400 : 0,
            height: 400,
            child: Container(
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}
