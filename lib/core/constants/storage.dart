import 'package:get_storage/get_storage.dart';

class StorageReferences {
  final box = GetStorage();

  static const String authData = 'authData';

  // DOKU
  static const String urlPaymentDoku = 'urlPaymentDoku';
  static const String dokuBankVA = 'dokuBankVA';
  static const String expiredAtVA = 'VA_expiredAt';

  // Transaction
  static const String invoiceId = 'invoiceId';
  static const String transactionId = 'transactionId';

  List<int?> getInvoiceIdArrayFromLocalStorage() {
    List<int?> arrInvoiceId = [];
    final invoiceIdSelected = box.read(invoiceId);
    if (invoiceIdSelected != null) {
      String inv = invoiceIdSelected;
      RegExp digitRegex = RegExp(r'\d');
      bool containsNumbers = digitRegex.hasMatch(inv);

      if (containsNumbers) {
        arrInvoiceId = inv
            .split(',')
            .map((value) => int.tryParse(value))
            .where((value) => value != null)
            .toList();
      }
    }

    return arrInvoiceId;
  }
}
