import 'package:flutter/material.dart';

class PathRouter {
  static const String rootScreen = "rootScreen";
  static const String loginScreen = "login";
  static const String registerScreen = "register";
  static const String verifyOtpScreen = "verifyOtpScreen";
  static const String notificationListScreen = "notificationList";
  static const String categoryListScreen = "categoryListScreen";
  static const String productDetailScreen = "productDetailScreen";
  static const String cartScreen = "cartScreen";
}


class MaterialPageRoutePlus<T> extends MaterialPageRoute<T> {
  MaterialPageRoutePlus({
    required super.builder,
    super.settings,
  });

  static final _iosBuilder = const CupertinoPageTransitionsBuilder();

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    if (settings.name == Navigator.defaultRouteName) {
      return child;
    }
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return super.buildTransitions(context, animation, secondaryAnimation, child);
    }
    return _iosBuilder.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
  }
}
