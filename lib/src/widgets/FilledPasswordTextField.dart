import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';

import '../core/constants/app_dimen.dart';

class FilledPasswordTextField extends StatefulWidget {
  final Color filledColor;
  final String hintText;
  final String? fontFamily;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final Function onImeAction;

  FilledPasswordTextField({
    Key? key,
    this.filledColor = Colors.white,
    this.fontFamily,
    this.textInputAction = TextInputAction.next,
    this.hintText = "",
    required this.onChanged,
    required this.onImeAction,
  }) : super(key: key);

  @override
  State<FilledPasswordTextField> createState() => _FilledPasswordTextFieldState();
}

class _FilledPasswordTextFieldState extends State<FilledPasswordTextField> {
  late TextEditingController textEditingController;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: hidePassword,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      onSubmitted: (value) {
        widget.onImeAction();
      },
      style: TextStyle(fontFamily: widget.fontFamily),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: widget.filledColor,
          suffixIcon: IconButton(
            icon: hidePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            splashRadius: 1,
            focusColor: AppColor.violet,
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
          ),
          hintText: widget.hintText),
    );
  }
}
