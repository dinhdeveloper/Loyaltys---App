import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as barcode_widget;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart' show MobileScanner, Barcode, MobileScannerController;
import 'package:remindbless/core/app_assets.dart' show Assets;
import 'package:remindbless/core/app_theme.dart';
import 'package:remindbless/presentation/widgets/common/animated_gradient_border_container.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isCameraBlurred = false; // trạng thái blur
  Timer? _blurTimer;

  @override
  void initState() {
    super.initState();
    // Khởi động timer 5s khi màn hình mở
    _blurTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isCameraBlurred = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 5),
              child: UnitText(text: "Trần Cảnh Dinh", fontSize: 16, fontFamily: Assets.sfProSemibold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: UnitText(text: "Thành viên mới", fontSize: 15, fontFamily: Assets.sfProLight, color: AppColors.colorButtonHome),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: UnitText(
                text: "Tích điểm thành viên được áp dụng tại các cửa hàng trực thuộc của hệ thống.",
                maxLines: 2,
                fontFamily: Assets.sfProLight,
              ),
            ),

            Center(
              child: AnimatedGradientBorderContainer(
                width: MediaQuery.of(context).size.width - 40,
                height: 100,
                borderRadius: 10,
                borderWidth: 1,
                gradientColors: [Colors.yellow, Colors.amber.shade400, Colors.orangeAccent],
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: _buildBarcodeWidget()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 20),
              child: UnitText(
                textAlign: TextAlign.center,
                text: "Để đảm bảo an toàn bảo mật, vui lòng không chia sẽ mã này với người khác.",
                maxLines: 2,
                fontFamily: Assets.sfProLight,
              ),
            ),

            Center(
              child: GestureDetector(
                onTap: () {
                  // Khi người dùng chạm vào camera, bỏ blur
                  if (_isCameraBlurred) {
                    setState(() {
                      _isCameraBlurred = false;
                    });
                    // Restart timer nếu muốn tự động blur lại sau 5s
                    _blurTimer?.cancel();
                    _blurTimer = Timer(const Duration(seconds: 5), () {
                      setState(() {
                        _isCameraBlurred = true;
                      });
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        color: Colors.black,
                        child: MobileScanner(
                          controller: cameraController,
                          fit: BoxFit.cover,
                          onDetect: (capture) {
                            final List<Barcode> barcodes = capture.barcodes;
                            if (barcodes.isNotEmpty) {
                              final String barcode = barcodes.first.displayValue ?? '';

                              /// có value quét barcode thì tích điểm
                            }
                          },
                        ),
                      ),
                      _buildScannerOverlay(), // overlay 4 góc
                      // Overlay mờ khi _isCameraBlurred = true
                      if (_isCameraBlurred)
                        Container(
                          width: 250,
                          height: 250,
                          color: Colors.black.withOpacity(0.6),
                          child: Center(child: SvgPicture.asset(Assets.iconHandPointer, width: 40, height: 40)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    _blurTimer?.cancel();
    super.dispose();
  }

  Widget _buildScannerOverlay() {
    return Positioned.fill(
      child: IgnorePointer(child: CustomPaint(painter: ScannerOverlayPainter())),
    );
  }

  Widget _buildBarcodeWidget() {
    final scannedBarcode = "TCD123456789029374";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        barcode_widget.BarcodeWidget(
          barcode: barcode_widget.Barcode.code128(),
          data: scannedBarcode,
          width: double.infinity,
          height: 50,
          color: Colors.black,
          drawText: false,
        ),
        const SizedBox(height: 4),
        // Chữ số tách ra
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: scannedBarcode.split('').map((c) => Text(c, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))).toList(),
          ),
        ),
      ],
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final double cornerOffset; // khoảng cách ra khỏi mép
  final double cornerLength; // chiều dài góc thẳng trước khi bo
  final double cornerRadius; // bán kính bo tròn

  ScannerOverlayPainter({this.cornerOffset = 30, this.cornerLength = 30, this.cornerRadius = 4});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    double o = cornerOffset;
    double l = cornerLength;
    double r = cornerRadius;

    // Hàm vẽ 1 góc bo tròn kiểu "L nhỏ + cung"
    void drawCorner(double x, double y, bool top, bool left) {
      Path path = Path();

      if (top && left) {
        path.moveTo(x + r, y); // đoạn ngang
        path.lineTo(x + l, y);
        path.moveTo(x, y + r); // đoạn dọc
        path.lineTo(x, y + l);
        // cung bo
        path.moveTo(x + r, y);
        path.arcToPoint(Offset(x, y + r), radius: Radius.circular(r), clockwise: false);
      } else if (top && !left) {
        path.moveTo(x - r, y);
        path.lineTo(x - l, y);
        path.moveTo(x, y + r);
        path.lineTo(x, y + l);
        path.moveTo(x - r, y);
        path.arcToPoint(Offset(x, y + r), radius: Radius.circular(r), clockwise: true);
      } else if (!top && left) {
        path.moveTo(x + r, y);
        path.lineTo(x + l, y);
        path.moveTo(x, y - r);
        path.lineTo(x, y - l);
        path.moveTo(x + r, y);
        path.arcToPoint(Offset(x, y - r), radius: Radius.circular(r), clockwise: true);
      } else if (!top && !left) {
        path.moveTo(x - r, y);
        path.lineTo(x - l, y);
        path.moveTo(x, y - r);
        path.lineTo(x, y - l);
        path.moveTo(x - r, y);
        path.arcToPoint(Offset(x, y - r), radius: Radius.circular(r), clockwise: false);
      }

      canvas.drawPath(path, paint);
    }

    // Vẽ 4 góc
    drawCorner(o, o, true, true);
    drawCorner(size.width - o, o, true, false);
    drawCorner(o, size.height - o, false, true);
    drawCorner(size.width - o, size.height - o, false, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
