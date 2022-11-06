import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static PreferredSizeWidget darkIconStatusBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
