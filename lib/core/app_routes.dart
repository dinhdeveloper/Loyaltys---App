import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppTransition {
  ios,
  material3,
}

class AppNavigator {
  static CustomTransitionPage buildPage({
    required Widget child,
    required GoRouterState state,
    AppTransition transition = AppTransition.material3,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {

        /// 🍎 iOS style (Cupertino)
          case AppTransition.ios:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: child,
            );

        /// 🟢 Material 3
          case AppTransition.material3:
          return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.05, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                ),
                child: child,
              ),
            );
        }
      },
    );
  }
}


