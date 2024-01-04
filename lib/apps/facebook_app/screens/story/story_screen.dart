import 'dart:async';
import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../home/home_screen.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final bool _isPlaying = false;
  late CarouselSliderController _sliderController;
  @override
  void initState() {
    log('_StoryScreenState initState');
    _sliderController = CarouselSliderController();
    super.initState();
  }

  @override
  void dispose() {
    log('_StoryScreenState dispose');
    _sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero${widget.index}',
      child: Scaffold(
        body: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: SafeArea(
            bottom: false,
            child: CarouselSlider.builder(
              unlimitedMode: true,
              controller: _sliderController,
              itemCount: 3,
              slideBuilder: (index) => Story(
                index: index,
              ),
              slideTransform: const CubeTransform(),
              slideIndicator: CircularSlideIndicator(
                padding: const EdgeInsets.only(bottom: 80),
                indicatorBorderColor: Colors.black,
              ),
              enableAutoSlider: true,
              autoSliderDelay: const Duration(seconds: 5),
              autoSliderTransitionTime: const Duration(milliseconds: 500),
            ),
          ),
        ),
      ),
    );
  }
}

class Story extends StatelessWidget {
  const Story({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/facebook/content$index.jpg',
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.ellipsis,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      backgroundImage:
                          AssetImage('assets/images/facebook/user$index.jpg'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    users[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: '메시지 보내기 ...',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.all(4),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: FaIcon(
                          FontAwesomeIcons.thumbsUp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: FaIcon(
                          FontAwesomeIcons.faceSmileBeam,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
