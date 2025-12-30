import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/presentation/screens/cart_screen.dart';
import 'package:remindbless/presentation/screens/scan_qrcode_screen.dart';
import 'package:remindbless/presentation/screens/search_screen.dart';
import 'package:remindbless/presentation/screens/setting_screen.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

import 'history_point_screen.dart';
import 'home_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  Key _homeKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final bgController = context.watch<BackgroundController>();

    final screens = [
      HomeScreen(key: _homeKey),
      HistoryPointScreen(),
      SearchScreen(),
      ScanQrCodeScreen(),
      SettingScreen(),
    ];

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: bgController.background,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(child: screens[_currentIndex]),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: CommonGlass(
        height: 60,
        colorBlur: Colors.white12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavIcon(Assets.iconHome, 0, "Trang chủ"),
            _buildNavIcon(Assets.iconHistory, 1, "Lịch sử"),
            _buildNavIcon(Assets.iconSearch, 2, "Tìm kiếm"),
            _buildNavIcon(Assets.iconScanQR, 3, "Tích điểm"),
            _buildNavIcon(Assets.iconProfile, 4, "Tài khoản"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(String icon, int index, String title) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, width: 24, height: 24,
              color: isSelected ? null : Colors.grey,
            ),
            UnitText(text: title, fontSize: 10,
              fontFamily: Assets.sfProLight,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) {
      if (index == 0) {
        setState(() {
          _homeKey = UniqueKey();
        });
      }
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}