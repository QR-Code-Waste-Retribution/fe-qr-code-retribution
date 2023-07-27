import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';

class StorageReferences {
  static final box = GetStorage();

  static const String authData = 'authData';
  static const String fcmToken = 'FCMToken';

  // DOKU
  static const String urlPaymentDoku = 'urlPaymentDoku';
  static const String dokuBankVA = 'dokuBankVA';
  static const String expiredAtVA = 'VA_expiredAt';

  // Transaction
  static const String invoiceId = 'invoiceId';
  static const String transactionId = 'transactionId';

  void removeStorageReferencesDokuPayment() {
    box.remove(expiredAtVA);
    box.remove(dokuBankVA);
    box.remove(urlPaymentDoku);
  }

  static String getAuthToken() {
    String? storedAuthData = box.read(authData);
    try {
      AuthData? authData = AuthData.fromJson(jsonDecode(storedAuthData!));
      return authData.accessToken;
    } catch (e) {}
    return '';
  }

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

  static void backToLogin() {
    Get.toNamed(Pages.loginPage);
    box.remove('authData');
    Get.offAllNamed('/');
    Get.deleteAll();
    Get.put(AuthProvider());
  }
}
