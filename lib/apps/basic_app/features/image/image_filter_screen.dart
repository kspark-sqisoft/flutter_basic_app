import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_filter_pro/photo_filter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img; //dart image library image

class ImageFilterScreen extends StatefulWidget {
  const ImageFilterScreen({super.key});

  @override
  State<ImageFilterScreen> createState() => _ImageFilterScreenState();
}

class _ImageFilterScreenState extends State<ImageFilterScreen> {
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;
  String? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Filter')),
      body: Column(children: [
        PhotoFilterView(widgetsToImageController: controller),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            print('widget capture started');
            final bytes = await controller.capture();
            setState(() {
              this.bytes = bytes;
            });
            print('widget capture completed');
          },
          child: const Text('Widget To Image'),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            print('save file started');
            File? file = await imageToFile(
              await uint8ListToImage(bytes!),
              path: 'D:/',
              name: 'image_filter',
              format: 'png',
            );
            print('save file completed path:${file!.path}');
            setState(() {
              imageFile = file.path;
            });
          },
          child: const Text('Save Image'),
        ),
        const SizedBox(
          height: 200,
        ),
      ]),
    );
  }

  Future<Uint8List?> imageToUint8List(ui.Image image,
      {ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    ByteData? byteData = await image.toByteData(format: format);
    List<int> bytes = byteData!.buffer.asUint8List();

    return Uint8List.fromList(bytes);
  }

  Future<File?> imageToFile(
    ui.Image image, {
    String? path,
    String? name,
    String? format = 'png',
  }) async {
    Uint8List? byte = await imageToUint8List(image);
    if (byte == null) return null;
    final directory = path ?? (await getTemporaryDirectory()).path;
    String fileName = name ?? DateTime.now().toIso8601String();
    String fullPath = format == 'png'
        ? '$directory/$fileName.png'
        : '$directory/$fileName.jpg';
    File imgFile = File(fullPath);
    return await imgFile.writeAsBytes(byte);
  }

  Future<ui.Image> uint8ListToImage(Uint8List bytes) async {
    ImageProvider provider = MemoryImage(bytes);
    return await loadImageFromProvider(provider);
  }

  Future<ui.Image> loadImageFromProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    Completer<ui.Image> completer = Completer<ui.Image>();
    late ImageStreamListener listener;
    ImageStream stream = provider.resolve(config);
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }
}

class PhotoFilterView extends StatefulWidget {
  const PhotoFilterView({super.key, required this.widgetsToImageController});
  final WidgetsToImageController widgetsToImageController; //parent

  @override
  State<PhotoFilterView> createState() => _PhotoFilterViewState();
}

class _PhotoFilterViewState extends State<PhotoFilterView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    image = null;
    super.dispose();
  }

  File? image;

  void _showImagePicker() async {
    // Implement your image picker logic here
    // Set the selected image as the imageFile
    // For example:
    final ImagePicker picker = ImagePicker();

    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    });

    if (image == null) {
      return;
    }

    var updatedImage = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(40),
          child: PhotoFilter(
            image: image!,
            cancelIcon: Icons.cancel,
            applyIcon: Icons.check,
            backgroundColor: Colors.black,
            sliderColor: Colors.blue,
            sliderLabelStyle: const TextStyle(color: Colors.white),
            bottomButtonsTextStyle: const TextStyle(color: Colors.white),
            presetsLabelTextStyle:
                const TextStyle(color: Colors.white, fontSize: 12),
            applyingTextStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    if (updatedImage != null) {
      setState(() {
        image = updatedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double outgap = 40;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightGreen,
            ),
            onPressed: _showImagePicker,
            child: const Text('Pick and Filter Image'),
          ),
          const SizedBox(
            height: 20,
          ),
          if (image != null)
            WidgetsToImage(
              controller: widget.widgetsToImageController,
              child: Container(
                  width: 1240,
                  height: 1844,
                  color: Colors.white,
                  constraints:
                      const BoxConstraints(maxWidth: 1240, maxHeight: 1844),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: outgap + 10, horizontal: outgap),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  )),
            )
        ],
      ),
    );
  }
}
