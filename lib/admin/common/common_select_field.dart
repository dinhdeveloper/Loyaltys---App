import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';
import 'package:remindbless/presentation/widgets/common/unit_text.dart';

class CommonSelectField<T> extends StatelessWidget {
  const CommonSelectField({
    super.key,
    required this.label,
    required this.value,
    required this.displayText,
    required this.onTap,
    this.hintText = 'Chọn danh mục',
  });

  final String label;
  final T? value;
  final String? displayText;
  final VoidCallback onTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: UnitText(text: label, fontSize: 15,fontFamily: Assets.sfProBold),
        ),

        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent, width: 1),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hasValue ? displayText ?? '' : hintText,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: Assets.sfProRegular,
                      color: hasValue ? Colors.black : Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
