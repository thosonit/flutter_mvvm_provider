import 'package:intl/intl.dart';

class DateUtils {
  /// Formats the given [date] as a string in dd/MM/yyyy format.
  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  /// Calculates the number of days between [from] and [to].
  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }
}
