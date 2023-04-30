import 'package:get_storage/get_storage.dart';

class StorageReferences {
  final box = GetStorage();

  static const String authData = 'authData';

  // DOKU
  static const String urlPaymentDoku = 'urlPaymentDoku';
  static const String invoiceId = 'invoiceId';

  List<int> getInvoiceIdArrayFromLocalStorage() {
    List<int> arrInvoiceId = [];
    final invoiceIdSelected = box.read(invoiceId);
    if (invoiceIdSelected != null) {
      RegExp digitRegex = RegExp(r'\d');
      bool containsNumbers = digitRegex.hasMatch(invoiceIdSelected);

      if (containsNumbers) {
        arrInvoiceId = invoiceIdSelected.split(',').map(int.parse).toList();
      }
    }
    return arrInvoiceId;
  }
}
