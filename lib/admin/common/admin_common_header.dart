import 'package:flutter/material.dart';

class AdminCommonHeader extends StatelessWidget {
  const AdminCommonHeader({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
    this.textAlign = TextAlign.center,
    this.color = Colors.black87,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// BACK BUTTON
          if (showBack)
            GestureDetector(
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black87,
              ),
            )
          else
            const SizedBox(width: 20), // giữ layout cân đối

          const SizedBox(width: 12),

          /// TITLE
          Expanded(
            child: Text(
              title,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
                shadows: const [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
          ),

          /// PLACEHOLDER bên phải để title luôn center
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}

