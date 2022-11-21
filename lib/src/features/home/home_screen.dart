import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';
import 'package:lost_and_found/src/features/global_widgets/poppin_text.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.MARGIN_MEDIUM_2,vertical: AppDimen.MARGIN_MEDIUM_2),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColor.violet,
              splashColor: AppColor.white,
              child: Icon(Icons.add),
            ),
          ),
        ),
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      ],
    );
  }
}
