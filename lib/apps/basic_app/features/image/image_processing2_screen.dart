import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ImageProcessing2Screen extends StatefulWidget {
  const ImageProcessing2Screen({super.key});

  @override
  State<ImageProcessing2Screen> createState() => _ImageProcessing2ScreenState();
}

class _ImageProcessing2ScreenState extends State<ImageProcessing2Screen> {
  //Load an image, resize it, and save it as a thumbnail jpeg
  Future<void> loadAndSaveThumbnail() async {
    //파일로 부터 jpg 읽기
    final image = img.decodeJpg(File('D:/image.jpg').readAsBytesSync());
    //리사이즈
    final thumbnail = img.copyResize(image!, width: 100);
    //저장하기
    img.encodeImageFile('D:/thumbnail.jpg', thumbnail);
  }

  //Load and process an image in a separate isolate thread
  Future<void> loadAndSaveThumbnailSeparateIsolateThread() async {
    await (img.Command()
          ..decodeImageFile('D:/image.jpg')
          ..copyResize(width: 100)
          ..gaussianBlur(radius: 5)
          ..writeToFile('D:/thumbnail.jpg'))
        .executeThread();
  }

  Future<void> createPng() async {
    await (img.Command()
          ..createImage(width: 256, height: 256)
          ..fill(color: img.ColorRgb8(0, 0, 255))
          ..drawString('Hello World', font: img.arial24, x: 0, y: 0)
          ..drawLine(
              x1: 0,
              y1: 0,
              x2: 256,
              y2: 256,
              color: img.ColorRgb8(255, 0, 0),
              thickness: 3)
          ..gaussianBlur(radius: 10)
          ..writeToFile('D:/test.png'))
        .execute();
  }

  Future<void> gifToPngFiles() async {
    ByteData data = await rootBundle.load('assets/animatedgif.gif');
    final anim = img.decodeGif(data.buffer.asUint8List());
    for (final frame in anim!.frames) {
      img.encodePngFile('D:/animated_${frame.frameIndex}.png', frame);
    }
  }

  Future<void> autoTrimImages() async {
    const path = 'D:/mytest';
    final dir = Directory(path);
    final files = dir.listSync();
    List<int>? trimRect;
    for (final f in files) {
      if (f is! File) {
        continue;
      }
      final bytes = f.readAsBytesSync();
      final image = img.decodeImage(bytes);
      if (image == null) {
        continue;
      }
      trimRect ??= img.findTrim(image, mode: img.TrimMode.transparent);
      final trimmed = img.copyCrop(image,
          x: trimRect[0],
          y: trimRect[1],
          width: trimRect[2],
          height: trimRect[3]);

      String name = f.uri.pathSegments.last;
      img.encodeImageFile('$path/trimmed-$name', trimmed);
    }
  }

  List<img.Image> splitImage(
      img.Image inputImage, int horizontalPieceCount, int verticalPieceCount) {
    img.Image image = inputImage;

    final pieceWidth = (image.width / horizontalPieceCount).round();
    final pieceHeight = (image.height / verticalPieceCount).round();
    final pieceList = List<img.Image>.empty(growable: true);

    for (var y = 0; y < image.height; y += pieceHeight) {
      for (var x = 0; x < image.width; x += pieceWidth) {
        pieceList.add(img.copyCrop(image,
            x: x, y: y, width: pieceWidth, height: pieceHeight));
      }
    }

    return pieceList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImageProcessing2'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              loadAndSaveThumbnail();
            },
            child: const Text('Load And Save Thumbnail'),
          ),
          ElevatedButton(
            onPressed: () {
              loadAndSaveThumbnailSeparateIsolateThread();
            },
            child:
                const Text('Load And Save Thumbnail Separate Isolate Thread'),
          ),
          ElevatedButton(
            onPressed: () {
              createPng();
            },
            child: const Text('Create PNG'),
          ),
          ElevatedButton(
            onPressed: () {
              gifToPngFiles();
            },
            child: const Text('GIF to PNG files'),
          ),
          ElevatedButton(
            onPressed: () {
              autoTrimImages();
            },
            child: const Text('Auto Trim'),
          ),
          ElevatedButton(
            onPressed: () {
              final inputImage =
                  img.decodeJpg(File('D:/image.jpg').readAsBytesSync());
              final images = splitImage(inputImage!, 2, 2);
              for (int i = 0; i < images.length; i++) {
                img.encodeImageFile('D:/mytest/split/img$i.jpg', images[i]);
              }
            },
            child: const Text('splitImage'),
          ),
        ]),
      ),
    );
  }
}
