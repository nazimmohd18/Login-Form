import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsets? margin;

  const CustomText(
    this.text, {
    Key? key,
    required this.fontSize,
    this.fontWeight,
    this.color = blackColor,
    this.letterSpacing = 0.5,
    this.maxLines,
    this.textAlign,
    this.textOverflow,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            letterSpacing: letterSpacing,
            overflow: textOverflow),
      ),
    );
  }
}
