import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  HeaderDelegate({required this.title});

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: UnitText(
        text: title,
        color: AppColors.colorButtonBold,
        fontSize: 20,
        fontFamily: Assets.sfProSemibold,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HeaderDelegate oldDelegate) {
    return oldDelegate.title != title;
  }
}
