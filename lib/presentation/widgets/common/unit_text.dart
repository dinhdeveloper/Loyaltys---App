import 'package:flutter/material.dart';
import 'package:remindbless/core/app_assets.dart';

class UnitText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? height;
  final int? maxLines;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final bool? lineThrough;
  final bool? underline;
  final Color? lineThroughColor;

  const UnitText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontFamily,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.height,
    this.maxLines,
    this.overflow,
    this.lineThrough = false,
    this.underline = false,
    this.lineThroughColor,
  });

  @override
  Widget build(BuildContext context) {
    TextDecoration decoration = TextDecoration.none;

    if (lineThrough == true) {
      decoration = TextDecoration.lineThrough;
    } else if (underline == true) {
      decoration = TextDecoration.underline;
    }
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        height: height,
        fontSize: fontSize,
        fontFamily: fontFamily ?? Assets.SfProRegular,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? Colors.black,
        decoration: decoration,
        //decoration: lineThrough == true ? TextDecoration.lineThrough : TextDecoration.none,
        decorationColor: lineThroughColor ?? (color ?? Colors.black),
        decorationThickness: 0.8,
      ),
    );
  }
}
