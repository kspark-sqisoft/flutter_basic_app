import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../riverpod_app/pages/medias/media_kit_video_player.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final List<String> _medias = [
    'https://i.blogs.es/718a10/img_2085/500_333.jpeg',
    'https://www.pexels.com/download/video/3195394/',
    'https://www.pexels.com/download/video/5752729/',
    'https://www.91-cdn.com/hub/wp-content/uploads/2023/09/iphone-15-production-india.jpg',
    'https://www.pexels.com/download/video/3756003/'
  ];
  List<int> intervals = [5, 20, 25, 5, 25];

  int _currentIndex = 0;
  late int _dynamicInterval;

  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    _dynamicInterval = intervals[_currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 570,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 20),
            onPageChanged: (index, reasen) {
              print('reason:$reasen');
              setState(() {
                _currentIndex = index;
                _dynamicInterval = intervals[index];
              });
              log('reason:$reasen  _currentIndex:$_currentIndex');
              //timed, manual, controller
              if (reasen == CarouselPageChangedReason.controller) {
              } else if (reasen == CarouselPageChangedReason.manual) {
              } else {
                if (_medias.length <= 2) {
                  _carouselController.jumpToPage(_currentIndex); //time
                } else {
                  _carouselController.animateToPage(_currentIndex); //time
                }
              }
            },
          ),
          itemCount: _medias.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            final path = _medias[itemIndex];
            //TODO 문제 있음 mimeType
            final mimeType = lookupMimeType(path);
            print('mimeType:$mimeType');
            if (mimeType == null) {
              return MediaKitVideoPlayer(
                path: path,
                fit: BoxFit.cover,
              );
            }
            if (mimeType.startsWith('image/')) {
              if (path.startsWith('http')) {
                return Image.network(
                  path,
                  fit: BoxFit.cover,
                );
              } else {
                return Image.file(
                  File(path),
                  fit: BoxFit.cover,
                );
              }
            } else {
              return MediaKitVideoPlayer(path: path, fit: BoxFit.cover);
            }
          },
        ),
        /*
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: _medias.length,
              effect: const WormEffect(),
              onDotClicked: (index) => _carouselController.animateToPage(index),
            ),
          ),
        ),
        */
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _medias.mapIndexed((index, entry) {
                return ProgressDot(
                  carouselController: _carouselController,
                  index: index,
                  currentIndex: _currentIndex,
                  duration: intervals[index],
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}

class ProgressDot extends StatelessWidget {
  const ProgressDot({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.carouselController,
    required this.duration,
  });
  final int index;
  final int currentIndex;
  final CarouselController carouselController;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Dot tap');
        carouselController.animateToPage(index);
      },
      child: Stack(
        children: [
          //배경
          Container(
            width: index == currentIndex ? 30 : 16,
            height: 16.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey.withOpacity(.8),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
          //위
          AnimatedContainer(
            duration: Duration(seconds: index == currentIndex ? duration : 0),
            width: index == currentIndex ? 30 : 16,
            height: 16.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: index == currentIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
