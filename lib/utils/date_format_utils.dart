import 'package:intl/intl.dart';

class DateFormatUtils {
  static String formatUnixTime(int unixTime) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat('hh:mm a').format(date);
  }
}