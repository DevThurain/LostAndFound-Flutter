import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';

import '../core/constants/app_dimen.dart';

class FilledTextField extends StatefulWidget {
  final Color filledColor;
  final String hintText;
  final String? fontFamily;
  final TextInputAction textInputAction;
  final Function(String) onChanged;

  FilledTextField({
    Key? key,
    this.filledColor = Colors.white,
    this.fontFamily,
    this.textInputAction = TextInputAction.next,
    this.hintText = "",
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontFamily: widget.fontFamily, decoration: TextDecoration.none),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.MARGIN_MEDIUM_2),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: widget.filledColor,
          hintText: widget.hintText),
    );
  }
}
