import 'package:flutter/material.dart';
import 'package:remindbless/core/go_router.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/services/network_service.dart';

import 'core/injector.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


void main() {
  setupLocator();
  runApp(
    Injector.wrapWithProviders(
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final NetworkService _networkService;

  @override
  void initState() {
    super.initState();
    _networkService = getIt<NetworkService>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _networkService.start(context);
  }

  @override
  void dispose() {
    _networkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: PathRouter.rootScreen,
      onGenerateRoute: Routers.generateRoute,
    );
  }
}


