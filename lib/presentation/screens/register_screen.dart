import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final bgController = context.watch<BackgroundController>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: bgController.background,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.transparent,
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
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: Assets.sfProRegular),
                      decoration: InputDecoration(
                        hintText: 'Nhập số điện thoại',
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.8), fontFamily: Assets.sfProRegular),
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

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: Assets.sfProRegular),
                      decoration: InputDecoration(
                        hintText: 'Nhập họ và tên',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.8), fontFamily: Assets.sfProRegular),
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
                      child: const UnitText(text: "Đăng ký", fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 40),

                  UnitText(text: "Đăng ký thành viên miễn phí"),
                  GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pop();
                      },
                      child: Container(color:Colors.transparent,child: UnitText(text: " Đăng nhập tại đây", color: AppColors.colorButtonHome, underline: true))),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomBarDetail(onTap:(){
          Navigator.of(context).pop();
        }),
      ),
    );
  }
}
