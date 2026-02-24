import 'package:intl/intl.dart';

class DateTimeUtils {
  static final DateFormat _dateTimeFmt = DateFormat('yyyy-MM-dd HH:mm:ss');

  static String formatDateTime(DateTime? value) {
    if (value == null) return '-';
    return _dateTimeFmt.format(value.toLocal());
  }

  static String toBackendDateTime(DateTime value) {
    return _dateTimeFmt.format(value.toLocal());
  }
}
