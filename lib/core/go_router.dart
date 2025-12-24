import 'package:flutter/material.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/presentation/screens/cart_screen.dart';
import 'package:remindbless/presentation/screens/category_list_screen.dart';
import 'package:remindbless/presentation/screens/login_screen.dart';
import 'package:remindbless/presentation/screens/notification_list_screen.dart';
import 'package:remindbless/presentation/screens/product_detail_screen.dart';
import 'package:remindbless/presentation/screens/register_screen.dart';
import 'package:remindbless/presentation/screens/root_screen.dart';
import 'package:remindbless/presentation/screens/verify_otp_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PathRouter.rootScreen:
        return MaterialPageRoutePlus(builder: (_) => const RootScreen());
      case PathRouter.loginScreen:
        return MaterialPageRoutePlus(builder: (_) => const LoginScreen());
      case PathRouter.registerScreen:
        return MaterialPageRoutePlus(builder: (_) => const RegisterScreen());
      case PathRouter.verifyOtpScreen:
        return MaterialPageRoutePlus(builder: (_) => const VerifyOtpScreen());
      case PathRouter.notificationListScreen:
        return MaterialPageRoutePlus(builder: (_) => const NotificationListScreen());
      case PathRouter.categoryListScreen:
        return MaterialPageRoutePlus(builder: (_) => const CategoryListScreen(), settings: settings);
      case PathRouter.productDetailScreen:
        return MaterialPageRoutePlus(builder: (_) => const ProductDetailScreen(), settings: settings);
      case PathRouter.cartScreen:
        return MaterialPageRoutePlus(builder: (_) => const CartScreen(), settings: settings);

      default:
        return MaterialPageRoutePlus(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('${settings.name}'),
              ),
            ));
    }
  }
}
