import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

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
  List<int> intervals = [10, 20, 25, 10, 25];

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
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _medias.mapIndexed((index, entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(index),
                  child: Stack(
                    children: [
                      Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.3))),
                      ),
                      Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.lightGreen
                                    : Colors.lightBlue)
                                .withOpacity(_currentIndex == index ? 1 : 0)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
