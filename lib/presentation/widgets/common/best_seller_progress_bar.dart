import 'dart:math';
import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';

class BestSellerProgressBar extends StatefulWidget {
  final double progress; // 0 → 1
  final double height;
  final Color fillColor;
  final int soldCount; // count sold
  final Color? iconColor;

  const BestSellerProgressBar({
    super.key,
    required this.progress,
    this.height = 14,
    required this.fillColor,
    required this.soldCount,
    this.iconColor,
  });

  @override
  State<BestSellerProgressBar> createState() => _BestSellerProgressBarState();
}

class _BestSellerProgressBarState extends State<BestSellerProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _autoTextColor(Color bg) {
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth; // <-- FIX WIDTH
        final filledWidth = (fullWidth * widget.progress)
            .clamp(0.0, fullWidth)
            .toDouble(); // <-- FIX CLAMP type

        final text = "Đã bán ${widget.soldCount}";

        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.height / 2),
          child: Container(
            height: widget.height,
            width: fullWidth,
            color: Colors.grey.shade300,
            child: Stack(
              children: [
                // GRADIENT FILL
                Container(
                  height: widget.height,
                  width: filledWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.white.withOpacity(1.0 - widget.progress * 0.7),
                        widget.fillColor
                            .withOpacity(0.5 + widget.progress * 0.2),
                        widget.fillColor,
                      ],
                      stops: [
                        0.0,
                        (0.3 + widget.progress * 0.3)
                            .clamp(0.0, 1.0)
                            .toDouble(),
                        1.0,
                      ],
                    ),
                  ),
                ),

                // TEXT + FLASH ICON (trước text)
                Positioned.fill(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            final t = _controller.value;
                            final opacity = 0.6 + 0.4 * sin(t * 2 * pi);

                            return Opacity(
                              opacity: opacity,
                              child: Icon(
                                Icons.flash_on,
                                size: widget.height * 0.9,
                                color: widget.iconColor ??
                                    _autoTextColor(widget.fillColor),
                              ),
                            );
                          },
                        ),

                        SizedBox(width: widget.height * 0.25),

                        Text(
                          text,
                          style: TextStyle(
                            fontFamily: Assets.SfProMediumItalic,
                            fontWeight: FontWeight.w700,
                            fontSize: widget.height * 0.7,
                            height: 1.0,
                            color: _autoTextColor(widget.fillColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
