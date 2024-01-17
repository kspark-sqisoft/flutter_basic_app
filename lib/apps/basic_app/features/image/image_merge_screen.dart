import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'images_merge_helper.dart';

class ImageMergeScreen extends StatefulWidget {
  const ImageMergeScreen({super.key});

  @override
  State<ImageMergeScreen> createState() => _ImageMergeScreenState();
}

class _ImageMergeScreenState extends State<ImageMergeScreen> {
  late ui.Image assetImage1;
  late ui.Image assetImage2;

  late ui.Image mergeImage;

  late Uint8List? uint8listImage1;
  late Uint8List? uint8listImage2;

  late Uint8List? uint8listMergeImage;

  bool isReadyImages = false;

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  void loadImage() async {
    assetImage1 = await ImagesMergeHelper.loadImageFromAsset(
        'assets/images/facebook/story2.jpg');
    log('assetImage1.width:${assetImage1.width}');
    log('assetImage1.height:${assetImage1.height}');
    assetImage2 = await ImagesMergeHelper.loadImageFromAsset(
        'assets/images/facebook/story4.jpg');

    uint8listImage1 = await ImagesMergeHelper.imageToUint8List(assetImage1);
    uint8listImage2 = await ImagesMergeHelper.imageToUint8List(assetImage2);

    mergeImage = await ImagesMergeHelper.margeImages([assetImage1, assetImage2],
        direction: Axis.horizontal);

    uint8listMergeImage = await ImagesMergeHelper.imageToUint8List(mergeImage);

    isReadyImages = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: isReadyImages
          ? Column(
              children: [
                const Text('이미지 한개'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.memory(
                        uint8listImage1!,
                        width: 1080 / 2,
                        height: 1920 / 2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      child: Image.memory(
                        uint8listImage2!,
                        width: 1080 / 2,
                        height: 1920 / 2,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text('이미지 여러개 합치기'),
                Stack(
                  children: [
                    Container(
                      width: 1080,
                      height: 1920 / 2,
                      color: Colors.lightGreen,
                    ),
                    Container(
                      child: Image.memory(
                        uint8listMergeImage!,
                        width: 1080,
                        height: 1920 / 2,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
