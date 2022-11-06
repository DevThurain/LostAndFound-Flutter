import 'package:flutter/material.dart';
import 'package:lost_and_found/src/core/constants/app_color.dart';
import 'package:lost_and_found/src/core/constants/app_dimen.dart';

class IntroTitles extends StatelessWidget {
  final String title;
  final String subtitle;

  IntroTitles({this.title = "", this.subtitle = ""});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppColor.black,
                fontFamily: 'Poppins',
                fontSize: AppDimen.TEXT_REGULAR_3X,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppDimen.MARGIN_MEDIUM),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColor.darkGrey,
              fontFamily: 'Poppins',
              fontSize: AppDimen.TEXT_REGULAR,
            ),
          ),
        ],
      ),
    );
  }
}
