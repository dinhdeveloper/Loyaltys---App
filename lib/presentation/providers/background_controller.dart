import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundController extends ChangeNotifier {
  static const _keyBg = "app_background";

  ImageProvider _background = const AssetImage(Assets.imgBgAdmin);
  String _selectedAsset = Assets.imgBgAdmin;

  ImageProvider get background => _background;
  String get selectedAsset => _selectedAsset;

  Future<void> loadSavedBackground() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_keyBg);

    if (saved != null) {
      _selectedAsset = saved;
      _background = AssetImage(saved);
      notifyListeners();
    }
  }

  Future<void> applyAsset(String asset) async {
    _selectedAsset = asset;
    _background = AssetImage(asset);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyBg, asset);

    notifyListeners();
  }
}

