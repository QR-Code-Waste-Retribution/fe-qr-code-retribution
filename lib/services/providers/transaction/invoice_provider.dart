import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/exceptions/api_exception.dart';
import 'package:qr_code_app/models/invoice/invoice_paid_unpaid.dart';
import 'package:qr_code_app/models/invoice/invoice_model.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/pages/invoice/pemungut/invoice_page.dart';
import 'package:qr_code_app/services/repositories/invoice_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/logger.dart';
import 'package:qr_code_app/utils/number_format_price.dart';

class InvoiceProvider extends GetxController {
  final box = GetStorage();

  final InvoiceRepositories _invoiceRepositories = InvoiceRepositories();

  final Rx<InvoiceList> _invoice = InvoiceList(invoice: [], user: null).obs;

  final Rx<InvoicePaidUnPaid> _invoicePaidUnpaid = InvoicePaidUnPaid(
    usersPaid: UsersPaidUnPaid(records: []),
    usersUnpaid: UsersPaidUnPaid(records: []),
  ).obs;

  final Rx<InvoicePaidUnPaid> _invoicePaidUnpaidFiltered = InvoicePaidUnPaid(
    usersPaid: UsersPaidUnPaid(records: []),
    usersUnpaid: UsersPaidUnPaid(records: []),
  ).obs;

  RxBool isLoading = false.obs;

  bool get getIsLoading => isLoading.value;

  int get getInvoiceUsersPaidLength =>
      _invoicePaidUnpaidFiltered.value.usersPaid.records.length;

  int get getInvoiceUsersUnPaidLength =>
      _invoicePaidUnpaidFiltered.value.usersUnpaid.records.length;

  InvoicePaidUnPaid get getInvoicePaidUnPaid =>
      _invoicePaidUnpaidFiltered.value;

  List<Records> get getInvoiceUsersPaid =>
      _invoicePaidUnpaidFiltered.value.usersPaid.records;

  List<Records> get getInvoiceUsersUnPaid =>
      _invoicePaidUnpaidFiltered.value.usersUnpaid.records;

  InvoiceList get getInvoiceList => _invoice.value;

  int get getInvoiceLength => _invoice.value.invoice.length;

  InvoiceList get getInvoice => _invoice.value;

  User? get getInvoiceUser => _invoice.value.user;

  void filterUserByInvoiceStatus({
    required String str,
    required bool status,
  }) {
    InvoicePaidUnPaid result = InvoicePaidUnPaid(
      usersPaid: UsersPaidUnPaid(records: []),
      usersUnpaid: UsersPaidUnPaid(records: []),
    );

    if (str.isEmpty) {
      result = _invoicePaidUnpaid.value;
    }

    if (status) {
      result.usersPaid.records = _invoicePaidUnpaid.value.usersPaid.records
          .where((element) =>
              element.name.toLowerCase().contains(str.toLowerCase()))
          .toList();

      result.usersPaid.count = _invoicePaidUnpaid.value.usersPaid.count;
      result.usersUnpaid = _invoicePaidUnpaid.value.usersUnpaid;
    } else {
      result.usersUnpaid.records = _invoicePaidUnpaid.value.usersUnpaid.records
          .where((element) =>
              element.name.toLowerCase().contains(str.toLowerCase()))
          .toList();

      result.usersUnpaid.count = _invoicePaidUnpaid.value.usersUnpaid.count;
      result.usersPaid = _invoicePaidUnpaid.value.usersPaid;
    }

    _invoicePaidUnpaidFiltered.value = result;
  }

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
      {String? uuid, int? subDistrictId, int? pemungutId}) async {
    try {
      ResponseAPI response =
          await _invoiceRepositories.invoiceUserByUUIDandSubDistrict(
              subDistrictId: subDistrictId!,
              uuid: uuid,
              pemungutId: pemungutId);

      _invoice.value = InvoiceList.fromJson(response.data);

      Get.to(
        () => InvoicePage(
          invoiceList: InvoiceList(
            invoice: getInvoiceStatusUnPaid(),
            user: _invoice.value.user,
          ),
        ),
      );

      SnackBarCustom.success(message: response.message);
      update();
    } on ApiException catch (e) {
      SnackBarCustom.error(message: e.responseAPI!.message);
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
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
      {required int? pemungutId}) async {
    try {
      isLoading.value = true;

      ResponseAPI response = await _invoiceRepositories
          .allUserForInvoicePaidAndUnpaid(pemungutId: pemungutId!);
      _invoicePaidUnpaid.value = InvoicePaidUnPaid.fromJson(response.data);
      _invoicePaidUnpaidFiltered.value = _invoicePaidUnpaid.value;

      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
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
