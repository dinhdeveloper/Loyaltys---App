import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  late BuildContext context;
  bool isInit = false;
  Object? arguments;

  /// Hàm này gọi khi init lần đầu
  void initBaseData() {}
}