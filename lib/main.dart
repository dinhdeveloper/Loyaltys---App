import 'package:flutter/material.dart';
import 'package:remindbless/presentation/screens/notification_list_screen.dart';
import 'package:remindbless/presentation/screens/root_screen.dart';

import 'core/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: NotificationListScreen(),
  //   );
  // }
}