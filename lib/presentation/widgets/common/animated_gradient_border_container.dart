import 'package:flutter/material.dart';

class AnimatedGradientBorderContainer extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final Widget child;
  final List<Color> gradientColors; // ← Thêm gradient colors

  const AnimatedGradientBorderContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.gradientColors = const [Colors.yellow, Colors.orange, Colors.red],
  });

  @override
  State<AnimatedGradientBorderContainer> createState() => _AnimatedGradientBorderContainerState();
}

class _AnimatedGradientBorderContainerState extends State<AnimatedGradientBorderContainer>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _MovingGradientBorderPainter(
            progress: _controller.value,
            borderRadius: widget.borderRadius,
            borderWidth: widget.borderWidth,
            gradientColors: widget.gradientColors, // ← truyền vào painter
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _MovingGradientBorderPainter extends CustomPainter {
  final double borderRadius;
  final double borderWidth;
  final double progress;
  final List<Color> gradientColors; // ← gradient colors

  _MovingGradientBorderPainter({
    required this.borderRadius,
    required this.borderWidth,
    required this.progress,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(borderWidth / 2),
      Radius.circular(borderRadius),
    );

    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 6.28, // 2*PI
      colors: gradientColors,
      stops: List.generate(gradientColors.length, (index) => index / (gradientColors.length - 1)),
      transform: GradientRotation(6.28 * progress), // gradient quay
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _MovingGradientBorderPainter oldDelegate) => true;
}
