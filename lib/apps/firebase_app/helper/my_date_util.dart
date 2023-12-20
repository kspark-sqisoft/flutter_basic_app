import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateUtil {
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return DateFormat('aa hh시 mm분').format(date);

    //return TimeOfDay.fromDateTime(date).format(context);
  }
}
