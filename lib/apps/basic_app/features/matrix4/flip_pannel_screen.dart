import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flip_panel_plus/flip_panel_plus.dart';

class FlipPannelScreen extends StatefulWidget {
  const FlipPannelScreen({super.key});

  @override
  State<FlipPannelScreen> createState() => _FlipPannelScreenState();
}

class _FlipPannelScreenState extends State<FlipPannelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flip Pannel')),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          FlipClockPlus.simple(
            startTime: DateTime.now(),
            digitColor: Colors.white,
            backgroundColor: Colors.black,
            digitSize: 50.0,
            centerGapSpace: 0.0,
            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            height: 100,
            width: 70,
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: AnimatedImagePage(
              key: UniqueKey(),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.lightBlue,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.redAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedImagePage extends StatelessWidget {
  const AnimatedImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    const imageWidth = 719.0;
    const imageHeight = 720.0;
    const toleranceFactor = 0.033;
    const widthFactor = 0.125;
    const heightFactor = 0.5;

    final random = Random();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              0,
              1,
              2,
              3,
              4,
              5,
              6,
              7,
            ]
                .map((count) => FlipPanelPlus.stream(
                      itemStream: Stream.fromFuture(Future.delayed(
                          Duration(milliseconds: random.nextInt(20) * 100),
                          () => 1)),
                      itemBuilder: (_, value) => value <= 0
                          ? Container(
                              color: Colors.white,
                              width: widthFactor * imageWidth,
                              height: heightFactor * imageHeight,
                            )
                          : ClipRect(
                              child: Align(
                                alignment: Alignment(
                                    -1.0 +
                                        count * 2 * 0.125 +
                                        count * toleranceFactor,
                                    -1.0),
                                widthFactor: widthFactor,
                                heightFactor: heightFactor,
                                child: Image.asset(
                                  'assets/images/facebook/profile.jpg',
                                  width: imageWidth,
                                  height: imageHeight,
                                ),
                              ),
                            ),
                      initValue: 0,
                      spacing: 0.0,
                      direction: FlipDirection.up,
                    ))
                .toList(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              0,
              1,
              2,
              3,
              4,
              5,
              6,
              7,
            ]
                .map((count) => FlipPanelPlus.stream(
                      itemStream: Stream.fromFuture(Future.delayed(
                          Duration(milliseconds: random.nextInt(20) * 100),
                          () => 1)),
                      itemBuilder: (_, value) => value <= 0
                          ? Container(
                              color: Colors.white,
                              width: widthFactor * imageWidth,
                              height: heightFactor * imageHeight,
                            )
                          : ClipRect(
                              child: Align(
                                alignment: Alignment(
                                    -1.0 +
                                        count * 2 * 0.125 +
                                        count * toleranceFactor,
                                    1.0),
                                widthFactor: widthFactor,
                                heightFactor: heightFactor,
                                child: Image.asset(
                                  'assets/images/facebook/profile.jpg',
                                  width: imageWidth,
                                  height: imageHeight,
                                ),
                              ),
                            ),
                      initValue: 0,
                      spacing: 0.0,
                      direction: FlipDirection.down,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
