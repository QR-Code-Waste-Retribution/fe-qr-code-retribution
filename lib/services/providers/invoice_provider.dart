import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/invoice_model.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/pages/invoice/invoice.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InvoiceProvider extends GetxController {
  final InvoiceRepositories _invoiceRepositories = InvoiceRepositories();
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  final Rx<InvoiceList> _invoice = InvoiceList(invoice: [], user: null).obs;

  Future<void> getInvoiceUser({String? uuid}) async {
    try {
      ResponseAPI response = await _invoiceRepositories.getInvoiceUser(
          subDistrictId: 51, uuid: uuid);
      _invoice.value = InvoiceList.fromJson(response.data);

      InvoiceList data = InvoiceList.fromJson(response.data);
      Get.to(() => InvoicePage(invoiceList: data));

      Get.snackbar(
        "Success",
        response.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get invoice by ${uuid!} : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
