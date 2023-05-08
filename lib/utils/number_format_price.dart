import 'package:intl/intl.dart';

class NumberFormatPrice {
  String formatPrice({required int? price, int decimalDigits = 2}) {
    NumberFormat numberFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: decimalDigits,
    );
    return numberFormat.format(price);
  }
}
