import 'package:flutter/material.dart';

Widget bottomBarDetail({VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -1))],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Center(
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
            child: const Icon(Icons.close, size: 20),
          ),
        ),
      ),
    ),
  );
}
