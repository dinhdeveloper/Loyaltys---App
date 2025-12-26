import 'package:flutter/material.dart';
import 'package:remindbless/core/go_router.dart';
import 'package:remindbless/core/path_router.dart';

import 'core/injector.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    Injector.wrapWithProviders(
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: PathRouter.rootScreen,
      onGenerateRoute: Routers.generateRoute,
    );
  }
}

