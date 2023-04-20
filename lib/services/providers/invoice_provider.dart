import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/invoice_model.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/pages/invoice/pemungut/invoice_page.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class InvoiceProvider extends GetxController {
  final InvoiceRepositories _invoiceRepositories = InvoiceRepositories();
  // final AuthProvider _authProvider = Get.find<AuthProvider>();

  final Rx<InvoiceList> _invoice = InvoiceList(invoice: [], user: null).obs;
  final RxMap<String, String> _invoiceStatus = <String, String>{}.obs;

  InvoiceList get getInvoiceList => _invoice.value;

  int get getInvoiceLength => _invoice.value.invoice.length;

  InvoiceList get getInvoice => _invoice.value;

  // [true] Sudah Bayar || [false] Belum Bayar
  bool getStatusInvoice() {
    int count = 0;

    for (var item in _invoice.value.invoice) {
      if(item.status == 1) count++;
    }

    return count == _invoice.value.invoice.length ? true : false; 
  }

  Future<void> getInvoiceUserByUUIDandSubDistrict({String? uuid}) async {
    try {
      ResponseAPI response = await _invoiceRepositories
          .invoiceUserByUUIDandSubDistrict(subDistrictId: 51, uuid: uuid);
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

  Future<void> getInvoiceUserByUserId({required int? userId}) async {
    try {
      ResponseAPI response =
          await _invoiceRepositories.invoiceUserByUserId(userId: userId!);
      _invoice.value = InvoiceList.fromJson(response.data);

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
        'Failed to get invoice by $userId : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
