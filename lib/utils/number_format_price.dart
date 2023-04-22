import 'package:intl/intl.dart';

class NumberFormatPrice {
  String formatPrice(price) {
    NumberFormat numberFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 2,
    );
    return numberFormat.format(price);
  }
}
