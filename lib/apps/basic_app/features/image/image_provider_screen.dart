import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart'
    as img; //이미지 라이브러리, load and save format(JPG, PNG, BMP...)
import 'dart:ui' as ui;

import 'images_merge_helper.dart';

class ImageProviderScreen extends StatelessWidget {
  const ImageProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImageProvider'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/facebook/user0.jpg',
              width: 200,
              height: 200,
            ),
            //ImageProvider(추상 클래스)의 AssetImage 구현체
            const Image(
              width: 200,
              height: 200,
              image: AssetImage('assets/images/facebook/user1.jpg'),
            ),
            //ImageProvider(추상 클래스)의 NetworkImage 구현체
            const Image(
              width: 200,
              height: 200,
              image: NetworkImage('https://picsum.photos/200/300?random=1'),
            ),
            Image(
              width: 200,
              height: 200,
              image: FileImage(File('D:/image.jpg')),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/facebook/user2.jpg'))),
            ),
            const MyImage(),
            const MyImage2()
          ],
        ),
      ),
    );
  }
}

class MyImage extends StatefulWidget {
  const MyImage({super.key});

  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  bool imageReady = false;

  //flutter image
  ui.Image? _uiImage;
  //dart image library image
  img.Image? _imgImage;

  Uint8List? _uiImageUint8List;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    _imgImage = await decodeAsset('assets/images/facebook/user5.jpg');

    //효과 주기(이미지 프로세싱)
    _imgImage = img.billboard(_imgImage!);
    //_imgImage = img.pixelate(_imgImage!, size: 10);
    //_imgImage = img.copyCropCircle(_imgImage!);
    //_imgImage = img.copyRotate(_imgImage!, angle: 180);
    //_imgImage = img.copyResize(_imgImage!, width: 50); //thumbnail

    _uiImage = await convertImageToFlutterUi(_imgImage!);

    _uiImageUint8List = await ImagesMergeHelper.imageToUint8List(_uiImage!);

    imageReady = true;
    setState(() {});
  }

  Future<img.Image?> decodeAsset(String path) async {
    final data = await rootBundle.load(path);

    // Utilize flutter's built-in decoder to decode asset images as it will be
    // faster than the dart decoder.
    final buffer =
        await ui.ImmutableBuffer.fromUint8List(data.buffer.asUint8List());

    final id = await ui.ImageDescriptor.encoded(buffer);
    final codec = await id.instantiateCodec(
        targetHeight: id.height, targetWidth: id.width);

    final fi = await codec.getNextFrame();

    final uiImage = fi.image;
    final uiBytes = await uiImage.toByteData();

    final image = img.Image.fromBytes(
        width: id.width,
        height: id.height,
        bytes: uiBytes!.buffer,
        numChannels: 4);

    return image;
  }

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

  @override
  Widget build(BuildContext context) {
    return imageReady
        ? Column(
            children: [
              RawImage(
                image: _uiImage,
                width: 600,
                height: 600,
              ),
              //ImageProvider(추상 클래스)의 MemoryImage 구현체
              Image(
                image: MemoryImage(_uiImageUint8List!),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class MyImage2 extends StatefulWidget {
  const MyImage2({super.key});

  @override
  State<MyImage2> createState() => _MyImage2State();
}

class _MyImage2State extends State<MyImage2> {
  bool imageReady = false;

  //flutter image
  ui.Image? _uiImage;
  //dart image library image
  img.Image? _imgImage;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    _uiImage = await ImagesMergeHelper.loadImageFromNetwork(
        'https://picsum.photos/600/600?random=1');

    _imgImage = await convertFlutterUiToImage(_uiImage!);
    _imgImage = img.billboard(_imgImage!);

    _uiImage = await convertImageToFlutterUi(_imgImage!);

    setState(() {
      imageReady = true;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return imageReady
        ? Column(
            children: [
              RawImage(
                image: _uiImage,
                width: 600,
                height: 600,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
