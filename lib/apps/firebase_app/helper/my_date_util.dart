import 'package:intl/intl.dart';

class MyDateUtil {
  static String getFormattedTime({required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return DateFormat('aa hh시 mm분').format(date);
  }
}
