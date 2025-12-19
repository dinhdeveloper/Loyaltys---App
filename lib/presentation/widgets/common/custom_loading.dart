import 'dart:math';

import 'package:flutter/material.dart';

class NeonLoading extends StatefulWidget {
  const NeonLoading({super.key});

  @override
  State<NeonLoading> createState() => _NeonLoadingState();
}

class _NeonLoadingState extends State<NeonLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (_, _) {
              return CustomPaint(
                size: Size(80, 80),
                painter: _NeonArcPainter(controller.value),
              );
            },
          ),

          // logo ở giữa
          // SizedBox(
          //   width: widget.size * 0.35,
          //   child: widget.logo,
          // ),
        ],
      ),
    );
  }
}

class _NeonArcPainter extends CustomPainter {
  final double progress;

  _NeonArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.40;

    final List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ];

    final stroke = 1.2;

    for (int i = 0; i < colors.length; i++) {
      // Vòng chẵn → xoay phải, vòng lẻ → xoay trái
      final isClockwise = i % 2 == 0;
      final angleProgress = isClockwise ? progress : 1 - progress;

      final startAngle = (pi / 6) * i + angleProgress * 2 * pi;
      final sweepAngle = pi / 2;

      // Stroke chính
      final paintMain = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - i * 5),
        startAngle,
        sweepAngle,
        false,
        paintMain,
      );

      // Glow nhẹ
      final paintGlow = Paint()
        ..color = colors[i].withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - i * 5),
        startAngle,
        sweepAngle,
        false,
        paintGlow,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _NeonArcPainter oldDelegate) => true;
}