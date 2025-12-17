import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = '${info.version}+${info.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [SvgPicture.asset(Assets.iconEditProfile, width: 20, height: 20)]),
            ),
            Center(
              child: SizedBox(
                width: 65,
                height: 65,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.colorButtonHome,
                  child: SvgPicture.asset(Assets.iconProfile, width: 40, height: 40, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(child: UnitText(text: "Trần Cảnh Dinh", fontFamily: Assets.SfProMedium, fontSize: 16)),
            Center(child: UnitText(text: "0975.469.232", fontFamily: Assets.SfProLight, fontSize: 16,color: Colors.black45)),
            const SizedBox(height: 15),
            Center(child: Container(color: Colors.black12, height: 0.5, width: MediaQuery.of(context).size.width - 40)),
            const SizedBox(height: 55),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UnitText(
                        text: "Chính sách bảo mật thông tin", fontFamily: Assets.SfProRegular,
                      ),
                      SvgPicture.asset(Assets.iconNextAction,width: 14,height: 14)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(child: Container(color: Colors.black12, height: 0.5, width: MediaQuery.of(context).size.width - 100)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UnitText(
                        text: "Chính sách Bảo Mật Dữ Liệu Cá Nhân", fontFamily: Assets.SfProRegular,
                      ),
                      SvgPicture.asset(Assets.iconNextAction,width: 14,height: 14)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(child: Container(color: Colors.black12, height: 0.5, width: MediaQuery.of(context).size.width - 100)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UnitText(
                        text: "Đơn hàng đã mua", fontFamily: Assets.SfProRegular,
                      ),
                      SvgPicture.asset(Assets.iconNextAction,width: 14,height: 14)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(child: Container(color: Colors.black12, height: 0.5, width: MediaQuery.of(context).size.width - 100)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UnitText(
                        text: "Danh sách yêu thích", fontFamily: Assets.SfProRegular,
                      ),
                      SvgPicture.asset(Assets.iconNextAction,width: 14,height: 14)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(child: Container(color: Colors.black12, height: 0.5, width: MediaQuery.of(context).size.width - 100)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UnitText(
                        text: "Hotline: 0975.469.232", fontFamily: Assets.SfProRegular,
                      ),
                      SvgPicture.asset(Assets.iconNextAction,width: 14,height: 14)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(child: Container(color: Colors.black12, height: 0.5, width: MediaQuery.of(context).size.width - 100)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UnitText(
                        text: "Liên hệ", fontFamily: Assets.SfProRegular,
                      ),
                      SvgPicture.asset(Assets.iconNextAction,width: 14,height: 14)
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),
            Center(
              child: UnitText(text: "Phiên bản: $version", color: Colors.black45),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
