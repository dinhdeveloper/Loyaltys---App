import 'package:flutter/material.dart';
import 'package:remindbless/data/models/products/product_item.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class WidgetProductCardHome extends StatelessWidget {
  final ProductItem item;

  const WidgetProductCardHome({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            /// Background image
            Positioned.fill(
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            ),

            /// Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            /// Text bottom-left
            Positioned(
              left: 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UnitText(text: item.name,
                    color: Colors.white,
                    fontSize: 22, fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  UnitText(text: item.price,
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                  ),
                ],
              ),
            ),

            /// Arrow button bottom-right
            Positioned(
              right: 20,
              bottom: 20,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
