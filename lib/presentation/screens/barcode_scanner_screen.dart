
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart' as barcode_widget;

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {

  String? scannedBarcode = "1234567890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 90),

          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 100,
              child: _buildBarcodeWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeWidget() {
    if (scannedBarcode == null) return const SizedBox.shrink();

    final isNumeric = RegExp(r'^\d+$').hasMatch(scannedBarcode!);

    return barcode_widget.BarcodeWidget(
      barcode: isNumeric
          ? barcode_widget.Barcode.code128()
          : barcode_widget.Barcode.qrCode(),
      data: scannedBarcode!,
      width: 200,
      height: 80,
      color: Colors.black,
    );
  }
}