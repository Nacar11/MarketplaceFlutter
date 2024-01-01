import 'package:flutter/material.dart';
import 'dart:math';

class PentagonIcon extends StatelessWidget {
  const PentagonIcon({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(24, 24), // Set the size of the icon
      painter: PentagonPainter(), // Custom painter to draw the pentagon
    );
  }
}

class PentagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color =
          const Color.fromRGBO(72, 68, 78, 1.0) // Set the color of the pentagon
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;
    const double rotation = -1.256; // 72 degrees in radians

    Path path = Path();

    for (int i = 0; i < 5; i++) {
      final double x = centerX + radius * cos(rotation + i * 1.256);
      final double y = centerY + radius * sin(rotation + i * 1.256);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
