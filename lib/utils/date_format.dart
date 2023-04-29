import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class FormatDate {
  String format(dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);

    initializeDateFormatting('id_ID', null);

    String month = DateFormat.yMMMM('id_ID').format(dateTime);

    return month;
  }
}
