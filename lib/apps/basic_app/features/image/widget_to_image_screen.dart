import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'images_merge_helper.dart';

class WidgetToImageScreen extends StatefulWidget {
  const WidgetToImageScreen({super.key});

  @override
  State<WidgetToImageScreen> createState() => _WidgetToImageScreenState();
}

class _WidgetToImageScreenState extends State<WidgetToImageScreen> {
  WidgetsToImageController controller = WidgetsToImageController();

  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget To Image'),
      ),
      body: Column(
        children: [
          WidgetsToImage(
            controller: controller,
            child: const OriginalWidget(),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              final bytes = await controller.capture();
              setState(() {
                this.bytes = bytes;
              });
            },
            child: const Text('capture to image'),
          ),
          const SizedBox(
            height: 50,
          ),
          if (bytes != null)
            Image.memory(
              bytes!,
              width: 1080 + (16 * 3),
              height: 1920 / 2 + (16 * 2),
            ),
          const SizedBox(
            height: 50,
          ),
          if (bytes != null)
            ElevatedButton(
              onPressed: () async {
                await ImagesMergeHelper.imageToFile(
                    await ImagesMergeHelper.uint8ListToImage(bytes!),
                    path: 'D:/',
                    name: 'my_picture');
              },
              child: const Text('save image'),
            ),
        ],
      ),
    );
  }
}

class OriginalWidget extends StatelessWidget {
  const OriginalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: 1080 + (16 * 3),
      height: 1920 / 2 + (16 * 2),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 16, bottom: 16, right: 8),
                child: Image.asset(
                  'assets/images/facebook/story2.jpg',
                  width: 1080 / 2,
                  height: 1920 / 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, top: 16, bottom: 16, right: 16),
                child: Image.asset(
                  'assets/images/facebook/story4.jpg',
                  width: 1080 / 2,
                  height: 1920 / 2,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
