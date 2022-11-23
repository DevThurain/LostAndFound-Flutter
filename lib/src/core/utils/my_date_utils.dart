import 'package:flutter/material.dart';
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';

class MyDateUtils {
  static String getReadableDate(BuildContext context) {
    RelativeDateTime _relativeDateTime = RelativeDateTime(
        dateTime: DateTime.now(), other: DateTime.fromMicrosecondsSinceEpoch(1669134960087816));

    RelativeDateFormat _relativeDateFormatter = RelativeDateFormat(
      Localizations.localeOf(context),
    );

    return _relativeDateFormatter.format(_relativeDateTime);
  }
}
