import 'package:flutter/material.dart';


class DrawCircle extends CustomPainter {
  DrawCircle({
    required this.radius,
    required this.offset,
    required this.color,
    this.elevation = 8,
    this.transparentOccluder = true,
    required this.shadowColor,
    this.hasShadow = false,
    this.shadowOffset = 1,
  }) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  final double radius;
  final Offset offset;
  final Color color;
  final double elevation;
  final bool transparentOccluder;
  final bool hasShadow;
  final Color shadowColor;
  final double shadowOffset;
  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    if (hasShadow) {
      Path oval = Path()
        ..addOval(
            Rect.fromCircle(center: offset, radius: radius + shadowOffset));

      canvas.drawShadow(
        oval,
        shadowColor,
        elevation,
        transparentOccluder,
      );
    }

    canvas.drawCircle(offset, radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
