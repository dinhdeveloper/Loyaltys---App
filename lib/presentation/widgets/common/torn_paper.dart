import 'dart:math';

import 'package:flutter/material.dart';

class TornPaper extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double tearDepth;
  final double tearFrequency;
  final List<Color> gradientColors;
  final bool roundedBottom;
  final double cornerRadius;

  const TornPaper({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = 100,
    this.tearDepth = 12,
    this.tearFrequency = 8,
    this.gradientColors = const [
      Colors.white,
      Colors.white,
    ],
    this.roundedBottom = true,
    this.cornerRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: TornPainter(
          width: width,
          height: height,
          tearDepth: tearDepth,
          tearFrequency: tearFrequency,
          gradientColors: gradientColors,
          roundedBottom: roundedBottom,
          cornerRadius: cornerRadius,
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: tearDepth + 20,
            bottom: 20,
          ),
          child: child,
        ),
      ),
    );
  }
}

class TornPainter extends CustomPainter {
  final double width;
  final double height;
  final double tearDepth;
  final double tearFrequency;
  final List<Color> gradientColors;
  final bool roundedBottom;
  final double cornerRadius;

  TornPainter({
    required this.width,
    required this.height,
    required this.tearDepth,
    required this.tearFrequency,
    required this.gradientColors,
    required this.roundedBottom,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, width, height))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Top torn edge
    path.moveTo(0, tearDepth);

    for (double x = 0; x <= width; x += 1) {
      // Kết hợp nhiều sóng để tự nhiên
      final wave1 = sin(x / tearFrequency) * tearDepth * 0.5;
      final wave2 = cos(x / (tearFrequency * 2)) * tearDepth * 0.3;
      final y = tearDepth + wave1 + wave2;
      path.lineTo(x, y);
    }

    // Bottom edge
    if (roundedBottom) {
      path.lineTo(width, height - cornerRadius);
      path.quadraticBezierTo(
        width, height,
        width - cornerRadius, height,
      );
      path.lineTo(cornerRadius, height);
      path.quadraticBezierTo(
        0, height,
        0, height - cornerRadius,
      );
    } else {
      path.lineTo(width, height);
      path.lineTo(0, height);
    }

    path.close();

    // Shadow
    final shadowPath = Path.from(path);
    canvas.drawPath(
      shadowPath.shift(const Offset(0, 0)),
      Paint()
        ..color = Colors.black.withOpacity(0.09)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50),
    );

    // Main shape
    canvas.drawPath(path, paint);

    // Top edge highlight
    final highlightPath = Path();
    highlightPath.moveTo(0, tearDepth);
    for (double x = 0; x <= width; x += 2) {
      final wave1 = sin(x / tearFrequency) * tearDepth * 0.5;
      final wave2 = cos(x / (tearFrequency * 2)) * tearDepth * 0.3;
      final y = tearDepth + wave1 + wave2;
      highlightPath.lineTo(x, y);
    }

    canvas.drawPath(
      highlightPath,
      Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}