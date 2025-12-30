import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

import '../exceptions/exceptions.dart';

class CommonInputField extends StatelessWidget {
  const CommonInputField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.fontSize = 14,
    this.onChanged,
    this.enabled = true,
    this.onError = false,
    this.errorText,
    this.isNumberFormat = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final int? maxLength;
  final double fontSize;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool onError;
  final String? errorText;
  final TextCapitalization textCapitalization;

  /// NEW
  final bool isNumberFormat;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LABEL
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: UnitText(
            text: label,
            fontSize: 15,
            fontFamily: Assets.sfProBold,
          ),
        ),

        /// INPUT
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          enabled: enabled,
          onChanged: onChanged,
          textCapitalization: textCapitalization,
          inputFormatters: _buildFormatters(),
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontFamily: Assets.sfProRegular,
          ),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: Assets.sfProRegular,
            ),
            enabledBorder: _border,
            focusedBorder: _border,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
          ),
        ),

        if (onError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }

  List<TextInputFormatter>? _buildFormatters() {
    if (isNumberFormat) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        ThousandsFormatter(),
      ];
    }
    return inputFormatters;
  }

  OutlineInputBorder get _border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: onError ? Colors.redAccent : Colors.blueAccent, width: 1),
  );
}
