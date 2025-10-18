import 'package:intl/intl.dart';

class MyDateUtils {
  /// Accepts [Date] of any type and format it then  returns as [String].
  ///
  ///You can pass [format] to convert date into any specific format. You can
  ///also set [isIOSDate] to as [true/false].
  static String formatDate(
    dynamic date, {
    String format = "dd-MM-yyyy",
    bool isIOSDate = false,
  }) {
    switch (date.runtimeType) {
      case const (Null):
        return "";
      case const (String):
        DateTime temp =
            isIOSDate
                ? DateTime.parse(date)
                : DateFormat('dd-MM-yyyy').parse(date);

        return DateFormat(format).format(temp);
      default:
        return DateFormat(format).format(date);
    }
  }

  /// Converts [StringDate] into [DateTime] format.
  static getDate(String date) {
    // Define the input date format
    final DateFormat inputFormat = DateFormat('dd-MM-yyyy');

    // Parse the start date from the string
    DateTime finalDate = inputFormat.parseStrict(date);
    return finalDate;
  }
}
