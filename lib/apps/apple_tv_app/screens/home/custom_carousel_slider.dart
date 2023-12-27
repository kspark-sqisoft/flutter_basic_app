import 'dart:io';

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
  final _medias = [
    'https://i.blogs.es/718a10/img_2085/500_333.jpeg',
    'https://www.pexels.com/download/video/3195394/',
    'https://www.pexels.com/download/video/5752729/',
    'https://www.91-cdn.com/hub/wp-content/uploads/2023/09/iphone-15-production-india.jpg',
    'https://www.pexels.com/download/video/3756003/'
  ];

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 570,
        autoPlay: true,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 20),
        onPageChanged: (index, reasen) {
          print('reason:$reasen');
        },
      ),
      itemCount: _medias.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final path = _medias[itemIndex];

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
    );
  }
}
