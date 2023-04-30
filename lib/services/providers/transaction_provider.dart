import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/components/molekuls/webview/web_view_doku.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/transaction/transaction_invoice.dart';
import 'package:qr_code_app/models/transaction/transaction_list.dart';
import 'package:qr_code_app/models/transaction/transaction_store.dart';
import 'package:qr_code_app/models/doku/virtual_account/virtual_account_doku.dart';
import 'package:qr_code_app/models/doku/checkout/checkout.dart';
import 'package:qr_code_app/services/repositories/transaction_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class TransactionProvider extends GetxController {
  final box = GetStorage();

  final TransactionRepositories _transactionRepositories =
      TransactionRepositories();

  final Rx<TransactionInvoice> _transactionInvoice =
      TransactionInvoice(invoice: [], transaction: null).obs;

  final Rx<TransactionList> _transactionList =
      TransactionList(transaction: []).obs;

  final Rx<VirtualAccountDoku> _virtualAccoutnDoku =
      VirtualAccountDoku(order: null, virtualAccountInfo: null).obs;

  final Rx<Checkout> _checkout = Checkout(message: [], response: null).obs;

  final RxBool isLoading = false.obs;

  TransactionInvoice get getTransactionInvoice => _transactionInvoice.value;

  TransactionList get getTransactionList => _transactionList.value;

  String? get getURLPaymentDokuQRIS => _checkout.value.response?.payment?.url;
  String? get getURLPaymentDokuVA =>
      _virtualAccoutnDoku.value.virtualAccountInfo?.howToPayPage;

  Future<void> storeTransactionInvoiceMasyarakat(
      {required TransactionStore transactionStore}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .transactionInvoiceMasyarakat(transactionStore: transactionStore);

      _transactionInvoice.value = TransactionInvoice.fromJson(response.data);

      Get.toNamed('/invoice_payments_details');
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
        'Failed to store transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> getTransactionByMasyarakatId({int? masyarakatId}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .transactionByMasyarakatId(masyarakatId: masyarakatId!);

      _transactionList.value = TransactionList.fromJson(response.data);

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
        'Failed to get transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> getTransactionInvoiceMasyarakatVirtualAccount(
      {required TransactionStore transactionStore, required typeVA}) async {
    try {
      final urlPaymentDoku = box.read('urlPaymentDoku');
      if (urlPaymentDoku != null) {
        Get.to(
          () => WebViewDoku(
            url: urlPaymentDoku!,
          ),
        );
        return;
      }

      transactionStore.type = "NONCASH";
      transactionStore.method =
          Method(payments: 'VIRTUAL_ACCOUNT', type: typeVA);

      ResponseAPI response =
          await _transactionRepositories.transactionInvoiceMasyarakatNonCash(
              transactionStore: transactionStore);

      _virtualAccoutnDoku.value = VirtualAccountDoku.fromJson(response.data);
      box.write('urlPaymentDoku', jsonEncode(getURLPaymentDokuVA));

      Get.to(
        () => WebViewDoku(
          url: getURLPaymentDokuVA!,
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
        'Failed to get transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> getTransactionInvoiceMasyarakatQRIS(
      {required TransactionStore transactionStore}) async {
    try {
      final urlPaymentDoku = box.read('urlPaymentDoku');
      if (urlPaymentDoku != null) {
        Get.to(
          () => WebViewDoku(
            url: urlPaymentDoku!,
          ),
        );
        return;
      }

      transactionStore.type = "NONCASH";
      transactionStore.method = Method(payments: 'CHECKOUT', type: 'QRIS');

      ResponseAPI response =
          await _transactionRepositories.transactionInvoiceMasyarakatNonCash(
              transactionStore: transactionStore);

      _checkout.value = Checkout.fromJson(response.data);

      box.write('urlPaymentDoku', jsonEncode(getURLPaymentDokuQRIS));

      Get.to(
        () => WebViewDoku(
          url: getURLPaymentDokuQRIS!,
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
        'Failed to store transaction QRIS : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
