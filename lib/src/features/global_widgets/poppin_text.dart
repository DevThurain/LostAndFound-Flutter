import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';

class PoppinText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextOverflow? overflow;
  final int? maxLines;
  const PoppinText(this.text, {Key? key, this.style = const TextStyle(), this.overflow, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: style.copyWith(
        fontFamily: 'Poppins',
        fontSize: style.fontSize ?? AppDimen.TEXT_REGULAR,
      ),
    );
  }
}
