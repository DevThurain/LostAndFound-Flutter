import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';

class BasedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  BasedText(
      {this.text = "",
      this.fontSize = AppDimen.TEXT_REGULAR,
      this.fontColor = AppColor.black,
      this.fontWeight = FontWeight.w400,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
