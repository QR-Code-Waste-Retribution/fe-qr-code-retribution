import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/invoice/invoice_paid_unpaid.dart';
import 'package:qr_code_app/models/invoice/invoice_model.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/pages/invoice/pemungut/invoice_page.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class InvoiceProvider extends GetxController {
  final box = GetStorage();

  final InvoiceRepositories _invoiceRepositories = InvoiceRepositories();

  final Rx<InvoiceList> _invoice = InvoiceList(invoice: [], user: null).obs;
  final Rx<InvoicePaidUnPaid> _invoicePaidUnpaid =
      InvoicePaidUnPaid(usersPaid: null, usersUnpaid: null).obs;

  RxBool isLoading = false.obs;

  bool get getIsLoading => isLoading.value;

  InvoicePaidUnPaid get getInvoicePaidUnPaid => _invoicePaidUnpaid.value;

  InvoiceList get getInvoiceList => _invoice.value;

  int get getInvoiceLength => _invoice.value.invoice.length;

  InvoiceList get getInvoice => _invoice.value;

  User? get getInvoiceUser => _invoice.value.user;

  List<Invoice> getInvoiceStatusUnPaid() {
    List<Invoice> invoice = [];
    void searchForUnpaidInvoices(List<Invoice> invoiceList) {
      if (invoiceList.isEmpty) {
        return;
      }

      Invoice currentInvoice = invoiceList.first;

      if (currentInvoice.status == 0) {
        invoice.add(currentInvoice);
      }

      searchForUnpaidInvoices(invoiceList.sublist(1));
    }

    searchForUnpaidInvoices(getInvoiceList.invoice);

    return invoice;
  }

  // [true] Sudah Bayar || [false] Belum Bayar
  bool getStatusInvoice() {
    int count = 0;

    for (var item in _invoice.value.invoice) {
      if (item.status == 1) count++;
    }

    return count == _invoice.value.invoice.length ? true : false;
  }

  String getTotalInvoicePrice() {
    int count = 0;

    for (var item in _invoice.value.invoice) {
      if (item.status == 0) count += item.price.normalPrice;
    }

    return NumberFormatPrice().formatPrice(price: count);
  }

  Future<void> getInvoiceUserByUUIDandSubDistrict(
      {String? uuid, int? subDistrictId}) async {
    try {
      ResponseAPI response =
          await _invoiceRepositories.invoiceUserByUUIDandSubDistrict(
              subDistrictId: subDistrictId!, uuid: uuid);
      _invoice.value = InvoiceList.fromJson(response.data);

      print(_invoice.value.toJson().toString());

      Get.to(
        () => InvoicePage(
          invoiceList: InvoiceList(
            invoice: getInvoiceStatusUnPaid(),
            user: getInvoiceUser,
          ),
        ),
      );

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

  Future<void> getAllUserForInvoicePaidAndUnpaid(
      {required int? subDistrictId}) async {
    try {
      isLoading.value = true;

      ResponseAPI response = await _invoiceRepositories
          .allUserForInvoicePaidAndUnpaid(subDistrictId: subDistrictId!);
      _invoicePaidUnpaid.value = InvoicePaidUnPaid.fromJson(response.data);

      isLoading.value = false;
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get invoice : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
