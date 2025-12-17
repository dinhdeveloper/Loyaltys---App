import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.imgCoffeeSignBoard, width: 140),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: Assets.SfProRegular),
                    decoration: InputDecoration(
                      hintText: 'Nhập số điện thoại',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.8), fontFamily: Assets.SfProRegular),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 46,
                    decoration: BoxDecoration(color: AppColors.colorButtonHome, borderRadius: BorderRadius.circular(23)),
                    alignment: Alignment.center,
                    child: const UnitText(text: "Đăng nhập", fontSize: 16),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UnitText(text: "Bạn chưa có tài khoản?"),
                    GestureDetector(
                      onTap: (){
                        context.push(PathRouter.REGISTER_SCREEN);
                      },
                      child: Container(color:Colors.transparent,child: UnitText(text: " Đăng ký ngay", color: AppColors.colorButtonHome, underline: true))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomBarDetail(onTap:(){
        Navigator.of(context).pop();
      }),
    );
  }
}
