import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/presentation/screens/login_screen.dart';
import 'package:remindbless/presentation/screens/notification_list_screen.dart';
import 'package:remindbless/presentation/screens/register_screen.dart';
import 'package:remindbless/presentation/screens/root_screen.dart';

import 'app_routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return AppNavigator.buildPage(
          child: const RootScreen(),
          state: state,
          transition: Platform.isAndroid ? AppTransition.material3 : AppTransition.ios,
        );
      },
    ),
    GoRoute(
      path: PathRouter.LOGIN_SCREEN,
      pageBuilder: (context, state) {
        return AppNavigator.buildPage(
          child: const LoginScreen(),
          state: state,
          transition: Platform.isAndroid ? AppTransition.material3 : AppTransition.ios,
        );
      },
    ),

    GoRoute(
      path: PathRouter.REGISTER_SCREEN,
      pageBuilder: (context, state) {
        return AppNavigator.buildPage(
          child: const RegisterScreen(),
          state: state,
          transition: Platform.isAndroid ? AppTransition.material3 : AppTransition.ios,
        );
      },
    ),

    GoRoute(
      path: PathRouter.NOTIFICATION_LIST_SCREEN,
      pageBuilder: (context, state) {
        return AppNavigator.buildPage(
          child: const NotificationListScreen(),
          state: state,
          transition: Platform.isAndroid ? AppTransition.material3 : AppTransition.ios,
        );
      },
    ),
  ],
);
