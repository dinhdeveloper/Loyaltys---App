import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';

class CommonBackgroundScaffold extends StatelessWidget {
  const CommonBackgroundScaffold({
    super.key,
    this.backgroundImage = Assets.imgBgAdmin,
    required this.body,
    this.extendBody = true,
    this.resizeToAvoidBottomInset = true,
    this.safeAreaBottom = false,
    this.bottomNavigationBar,
    this.scrollable = true,
  });

  final String backgroundImage;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final bool resizeToAvoidBottomInset;
  final bool safeAreaBottom;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final content = scrollable
        ? SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: (bottomNavigationBar != null) ? 90 : 0,
      ),
      child: body,
    )
        : body;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: extendBody,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          bottom: safeAreaBottom,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: content,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}

