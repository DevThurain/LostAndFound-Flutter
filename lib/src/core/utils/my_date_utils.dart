import 'package:flutter/material.dart';
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';

class MyDateUtils {
  static String getReadableDate(BuildContext context, String millisString) {
    print("millis ----> " + millisString);
    int millis = int.parse(millisString);
    RelativeDateTime _relativeDateTime = RelativeDateTime(
        dateTime: DateTime.now(), other: DateTime.fromMicrosecondsSinceEpoch(millis));

    RelativeDateFormat _relativeDateFormatter = RelativeDateFormat(
      Localizations.localeOf(context),
    );

    return _relativeDateFormatter.format(_relativeDateTime);
  }
}
