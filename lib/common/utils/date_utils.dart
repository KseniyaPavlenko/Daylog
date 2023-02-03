import 'package:intl/intl.dart';

final _timeFormat = DateFormat('HH:mm:ss');
final _dateFormat = DateFormat('yyyy-MM-dd');
final _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

const List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

extension DateTimeX on DateTime {
  static DateTime? parseTime(String? time) {
    if (time == null) {
      return null;
    }
    return _timeFormat.parse(time);
  }

  String formatTime() {
    return _timeFormat.format(this);
  }

  String formatDate() {
    return _dateFormat.format(this);
  }

  String formatDateTime() {
    return _dateTimeFormat.format(this);
  }

  String toMonth() {
    return months[month - 1].substring(0, 3).toUpperCase();
  }

  bool isBetween(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;

    if (isBefore(endDate) && isAfter(startDate)) return true;
    final now = DateTime(year, month, day);
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);

    return now.compareTo(start) == 0 || now.compareTo(end) == 0;
  }

  bool compareDate(DateTime date) {
    final currentDay = DateTime(year, month, day);
    final compareDay = DateTime(date.year, date.month, date.day);
    return currentDay.compareTo(compareDay) == 0;
  }
}
