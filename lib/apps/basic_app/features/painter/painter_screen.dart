import 'dart:math';

import 'package:flutter/material.dart';

class PainterScreen extends StatelessWidget {
  const PainterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painter')),
      body: Column(
        children: [
          //CustomPaint painter에게 그려질 영역의 크기 제공
          CustomPaint(
            painter: SmilingFacePainter(),
            size: const Size(500, 500),
          )
        ],
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
