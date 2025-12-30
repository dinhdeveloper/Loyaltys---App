import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/presentation/providers/background_controller.dart';
import 'package:remindbless/presentation/widgets/common/bottom_bar_widget.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  bool _isPhoneInvalid = false;

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
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: Assets.sfProRegular),
                      onChanged: (valuePhone) {
                        // Khi user sửa lại số → bỏ trạng thái lỗi
                        if (_isPhoneInvalid && valuePhone.length <= 10) {
                          setState(() {
                            _isPhoneInvalid = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Nhập số điện thoại',
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.8), fontFamily: Assets.sfProRegular),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: _isPhoneInvalid ? Colors.red : Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(color: _isPhoneInvalid ? Colors.red : Colors.grey, width: 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 16),

                  GestureDetector(
                    onTap: () {
                      final phone = phoneController.text.trim();

                      if (phone.length != 10) {
                        // Sai → đổi border đỏ
                        setState(() {
                          _isPhoneInvalid = true;
                        });
                        return;
                      }

                      // Đúng → reset lỗi & qua màn OTP
                      setState(() {
                        _isPhoneInvalid = false;
                      });
                      Navigator.pushNamed(context, PathRouter.verifyOtpScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 46,
                        decoration: BoxDecoration(color: AppColors.colorButtonHome, borderRadius: BorderRadius.circular(23)),
                        alignment: Alignment.center,
                        child: const UnitText(text: "Đăng nhập", fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UnitText(text: "Bạn chưa có tài khoản?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PathRouter.registerScreen);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: UnitText(text: " Đăng ký ngay", color: AppColors.colorButtonHome, underline: true),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomBarDetail(
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
