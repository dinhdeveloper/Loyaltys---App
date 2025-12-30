import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/core/path_router.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

import '../providers/background_controller.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController otpController = TextEditingController();

  bool _isOtpValid = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

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
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.imgCoffeeSignBoard, width: 140),

                  const SizedBox(height: 16),

                  UnitText(
                    text: "Mã xác thực gồm 6 chữ số đã được gửi qua\ntin nhắn đến số điện thoại 0975469232",
                    textAlign: TextAlign.center,
                    fontSize: 15,
                    fontFamily: Assets.sfProLight,
                    color: AppColors.colorButtonHome,
                  ),

                  const SizedBox(height: 30),

                  // OTP input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: Assets.sfProRegular),
                      onChanged: (value) {
                        setState(() {
                          _isOtpValid = value.length == 6;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Nhập mã OTP',
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

                  const SizedBox(height: 16),

                  // Button xác nhận
                  GestureDetector(
                    onTap: _isOtpValid
                        ? () {
                            Navigator.pushNamedAndRemoveUntil(context, PathRouter.rootScreen, (route) => false);
                        }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 46,
                        decoration: BoxDecoration(
                          color: _isOtpValid ? AppColors.colorButtonHome : Colors.grey.shade300, // disable
                          borderRadius: BorderRadius.circular(23),
                        ),
                        alignment: Alignment.center,
                        child: UnitText(text: "Xác nhận", fontSize: 16, color: _isOtpValid ? Colors.white : Colors.black38),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  UnitText(text: "Bạn không nhận được mã? Gửi lại (59s)"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
