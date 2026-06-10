import 'package:intl/intl.dart';

class HelperClass {
  static String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);

    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }
}
