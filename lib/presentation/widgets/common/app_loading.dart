import 'package:flutter/material.dart';
import 'package:remindbless/main.dart';

import 'custom_loading.dart';

class AppLoading {
  static OverlayEntry? _overlayEntry;

  static void show() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_overlayEntry != null) return;

      final overlay = navigatorKey.currentState?.overlay;
      if (overlay == null) return;

      _overlayEntry = OverlayEntry(
        builder: (_) => const _LoadingOverlay2(),
      );

      overlay.insert(_overlayEntry!);
    });
  }

  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // block touch
        Positioned.fill(
          child: AbsorbPointer(
            absorbing: true,
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),
        ),

        // loading center
        Center(
          child: NeonLoading(
            //logo: Image.asset(Assets.imgIconApp
            //), // logo app của bạn
          ),
        ),
      ],
    );
  }
}

class _LoadingOverlay2 extends StatefulWidget {
  const _LoadingOverlay2();

  @override
  State<_LoadingOverlay2> createState() => _LoadingOverlay2State();
}

class _LoadingOverlay2State extends State<_LoadingOverlay2>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          const Center(child: NeonLoading()),
        ],
      ),
    );
  }
}


