import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';

class PoppinText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const PoppinText(this.text, {Key? key,this.style = const TextStyle()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        fontFamily: 'Poppins',
        fontSize: style.fontSize ?? AppDimen.TEXT_REGULAR,
      ),
    );
  }
}
