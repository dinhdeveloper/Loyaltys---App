import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            /// HEADER PINNED
            SliverPersistentHeader(
              pinned: true,
              delegate: _HeaderDelegate(),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===== HEADER =====
class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: const UnitText(
        text: "Giỏ Hàng",
        color: AppColors.colorButtonBold,
        fontSize: 18,
        fontFamily: Assets.sfProSemibold,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}