import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart'
    as img; //이미지 라이브러리, load and save format(JPG, PNG, BMP...)
import 'dart:ui' as ui;

import 'images_merge_helper.dart';

Future<ui.Image> convertImageToFlutterUi(img.Image image) async {
  if (image.format != img.Format.uint8 || image.numChannels != 4) {
    final cmd = img.Command()
      ..image(image)
      ..convert(format: img.Format.uint8, numChannels: 4);
    final rgba8 = await cmd.getImageThread();
    if (rgba8 != null) {
      image = rgba8;
    }
  }

  ui.ImmutableBuffer buffer =
      await ui.ImmutableBuffer.fromUint8List(image.toUint8List());

  ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer,
      height: image.height,
      width: image.width,
      pixelFormat: ui.PixelFormat.rgba8888);

  ui.Codec codec = await id.instantiateCodec(
      targetHeight: image.height, targetWidth: image.width);

  ui.FrameInfo fi = await codec.getNextFrame();
  ui.Image uiImage = fi.image;

  return uiImage;
}

Future<img.Image> convertFlutterUiToImage(ui.Image uiImage) async {
  final uiBytes = await uiImage.toByteData();

  final image = img.Image.fromBytes(
      width: uiImage.width,
      height: uiImage.height,
      bytes: uiBytes!.buffer,
      numChannels: 4);

  return image;
}

class ImageProcessingScreen extends StatefulWidget {
  const ImageProcessingScreen({super.key});

  @override
  State<ImageProcessingScreen> createState() => _ImageProcessingScreenState();
}

class _ImageProcessingScreenState extends State<ImageProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Processing')),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AnimatedImage(),
          ],
        ),
      ),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  const AnimatedImage({super.key});

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> {
  bool imageReady = false;

  //flutter image
  ui.Image? _uiImage;
  //dart image library image
  img.Image? _imgImage;

  Uint8List? _uiImageBytes;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    _uiImage =
        await ImagesMergeHelper.loadImageFromAsset('assets/animatedgif.gif');

    _imgImage = await convertFlutterUiToImage(_uiImage!);

    //_uiImage = await convertImageToFlutterUi(_imgImage!);

    ByteData? byteData = await _uiImage!.toByteData();
    _uiImageBytes = byteData?.buffer.asUint8List();

    //print('_uiImageBytes:$_uiImageBytes');

    imageReady = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return imageReady
        ? Column(
            children: [
              const CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage('assets/animatedgif.gif'),
              ),
              Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/animatedgif.gif'))),
              ),
              /*
              Image(
                image: MemoryImage(_uiImageBytes!),
                width: 300,
                height: 300,
              ),
              */

              /*
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(image: MemoryImage(_uiImageBytes!))),
              ),
              */
              Image.asset(
                'assets/animatedgif.gif',
                width: 300,
                height: 300,
              ),
              Image.asset(
                'assets/APNG-cube.png',
                width: 300,
                height: 300,
              ),
              Image.asset(
                'assets/APNG-Icos4D.png',
                width: 300,
                height: 300,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
