import 'package:flutter/material.dart';
import 'package:remindbless/admin/common/admin_common_header.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/presentation/widgets/common/common_glass.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({super.key});

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  final List<Map<String, dynamic>> menuItems = const [
    {"title": "Danh mục", "icon": Icons.category, "color": Color(0xFF4facfe)},
    {"title": "Sản phẩm", "icon": Icons.trending_up, "color": Color(0xFF00f2fe)},
    {"title": "Banner", "icon": Icons.local_offer, "color": Color(0xFF667eea)},
    {"title": "Khác", "icon": Icons.settings, "color": Color(0xFF764ba2)},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imgBgAdmin),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column( mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Center(child: const AdminCommonHeader(title: "Trang Chủ",showBack: false)),

                  const SizedBox(height: 20),

                  /// GRID 4 ITEM
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: (){
                            onTapItemAdmin(index);
                          },
                          child: _buildMenuItem(context, menuItems[index]['title'], menuItems[index]['icon'], menuItems[index]['color'], index));
                    },
                  ),

                  const SizedBox(height: 24),

                  /// 🔹 CHART (placeholder – sau này thay bằng chart thật)
                  _chartPlaceholder(),
                ],
              ),
            ),
          ),
      ),
    );
  }

  // ================= MENU ITEM =================
  Widget _buildMenuItem(BuildContext context, String title, IconData icon, Color color, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        final v = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: v,
          child: Opacity(opacity: v, child: child),
        );
      },
      child: CommonGlass(
        radius: 10,
        blur: 20,
        colorBlur: Colors.white24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: color.withOpacity(0.6), shape: BoxShape.circle),
              child: Icon(icon, size: 30, color: AppColors.colorText),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.colorText, fontFamily: Assets.sfProMedium),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CHART PLACEHOLDER =================
  Widget _chartPlaceholder() {
    return CommonGlass(
      radius: 10,
      blur: 20,
      colorBlur: Colors.white24,
      height: 200,
      width: double.infinity,
      child: const UnitText(text: "Chart sẽ đặt ở đây", fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  void onTapItemAdmin(int index) {
    if(index == 0){
      Navigator.pushNamed(context, PathRouter.adminCategories);
    }
    if(index == 1){
      Navigator.pushNamed(context, PathRouter.adminProducts);
    }

  }
}
