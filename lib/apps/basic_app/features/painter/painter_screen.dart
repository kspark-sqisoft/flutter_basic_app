import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PainterScreen extends StatefulWidget {
  const PainterScreen({super.key});

  @override
  State<PainterScreen> createState() => _PainterScreenState();
}

class _PainterScreenState extends State<PainterScreen> {
  ui.Image? image;

  Future<void> loadImage(String imagePath) async {
    //asset 이미지 => ui.Image
    ByteData data = await rootBundle.load(imagePath);
    List<int> bytes = data.buffer.asUint8List();
    image = await decodeImageFromList(Uint8List.fromList(bytes));

    setState(() {});
  }

  @override
  void initState() {
    loadImage('assets/images/facebook/profile.jpg');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painter')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //CustomPaint painter에게 그려질 영역의 크기 제공
              CustomPaint(
                painter: SmilingFacePainter(),
                size: const Size(200, 200),
              ),
              const SizedBox(
                height: 50,
              ),
              if (image != null)
                CustomPaint(
                  painter: ImagePainter(image: image!),
                  size: const Size(200, 200),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmilingFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Set the color to blue
    paint.color = Colors.blue;

    // Create a circle for the face
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);

    paint.color = Colors.white;
    // Create two eyes
    final eyeOffset = radius / 3;
    final leftEye = Offset(center.dx - eyeOffset, center.dy - eyeOffset);
    final rightEye = Offset(center.dx + eyeOffset, center.dy - eyeOffset);
    final eyeRadius = radius / 6;
    canvas.drawCircle(leftEye, eyeRadius, paint);
    canvas.drawCircle(rightEye, eyeRadius, paint);

    // Create a smile
    final smilePath = Path();
    smilePath.moveTo(center.dx - radius / 2, center.dy);
    smilePath.quadraticBezierTo(
        center.dx, center.dy + radius / 2, center.dx + radius / 2, center.dy);
    canvas.drawPath(smilePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ImagePainter extends CustomPainter {
  final ui.Image image;
  ImagePainter({required this.image});
  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = const Offset(0, 0);
    Rect srcRect = Rect.fromPoints(
        offset, Offset(image.width.toDouble(), image.height.toDouble()));
    Rect distRect = Rect.fromPoints(
        offset, Offset(offset.dx + size.width, offset.dy + size.height));
    canvas.drawImageRect(image, srcRect, distRect, Paint());

    final paint = Paint();
    paint.color = Colors.red.withOpacity(.5);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);

    final textPainter = TextPainter();
    textPainter.text = const TextSpan(text: '박기순');
    textPainter.textAlign = TextAlign.center;
    textPainter.textDirection = TextDirection.ltr;
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
