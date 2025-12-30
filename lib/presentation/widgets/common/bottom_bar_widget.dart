import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';

Widget bottomBarDetail({VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: CommonGlass(
      height: 75,
      colorBlur: Colors.white24,
      // decoration: const BoxDecoration(
      //   color: Colors.transparent,
      //   borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      //   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -1))],
      // ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30,left: 15, right: 15),
        child: Center(
          child: SvgPicture.asset(Assets.iconBackAppbar, width: 35, height: 35),
        ),
      ),
    ),
  );
}
