import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/components/molekuls/webview/web_view_doku.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/core/constants/storage.dart';
import 'package:qr_code_app/models/transaction/transaction.dart';
import 'package:qr_code_app/models/transaction/transaction_invoice.dart';
import 'package:qr_code_app/models/transaction/transaction_list.dart';
import 'package:qr_code_app/models/transaction/transaction_store.dart';
import 'package:qr_code_app/models/doku/virtual_account/virtual_account_doku.dart';
import 'package:qr_code_app/models/doku/checkout/checkout.dart';
import 'package:qr_code_app/services/repositories/transaction_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/models/transaction/transaction_noncash.dart';
import 'package:qr_code_app/models/transaction/method.dart';

class TransactionProvider extends GetxController {
  final box = GetStorage();

  final TransactionRepositories _transactionRepositories =
      TransactionRepositories();

  final Rx<Transaction?> _transaction = Rx<Transaction?>(null);

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

  int? get getTransactionId => _checkout.value.transactionId;

  String? get getURLPaymentDokuQRIS => _checkout.value.response?.payment?.url;

  String? get getURLPaymentDokuVA =>
      _virtualAccoutnDoku.value.virtualAccountInfo?.howToPayPage;

  Future<void> storeTransactionInvoiceMasyarakat(
      {required TransactionStore transactionStore}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .transactionInvoiceMasyarakat(transactionStore: transactionStore);

      _transactionInvoice.value = TransactionInvoice.fromJson(response.data);
      isLoading.value = false;

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

  Future<void> storeTransactionAdditionalMasyarakat(
      {required TransactionStore transactionStore}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .transactionAdditionalMasyarakat(transactionStore: transactionStore);

      _transactionInvoice.value = TransactionInvoice.fromJson(response.data);
      _transactionInvoice.value.invoice = [];
      isLoading.value = false;

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

  Future<void> getAllTransactionByPemungutId({required int? pemungutId}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .allTransactionByPemungutId(pemungutId: pemungutId!);

      _transactionList.value = TransactionList.fromJson(response.data);
      isLoading.value = false;

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
      {required TransactionNonCash transactionNonCash, required typeVA}) async {
    try {
      final urlPaymentDoku = box.read(StorageReferences.urlPaymentDoku);
      if (urlPaymentDoku != null) {
        Get.to(
          () => WebViewDoku(
            url: urlPaymentDoku!,
            transactionId: getTransactionId!,
          ),
        );
        return;
      }

      transactionNonCash.type = "NONCASH";
      transactionNonCash.method =
          Method(payments: 'VIRTUAL_ACCOUNT', type: typeVA);

      ResponseAPI response =
          await _transactionRepositories.transactionInvoiceMasyarakatNonCash(
              transactionNonCash: transactionNonCash);

      _virtualAccoutnDoku.value = VirtualAccountDoku.fromJson(response.data);
      box.write(
          StorageReferences.urlPaymentDoku, jsonEncode(getURLPaymentDokuVA));

      Get.to(
        () => WebViewDoku(
          url: getURLPaymentDokuVA!,
          transactionId: getTransactionId!,
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

  Future<void> updateStatusTransaction(
      {required List<int?> arrInvoiceId, required int transactionId}) async {
    try {
      final urlPaymentDokuStorage = box.read(StorageReferences.urlPaymentDoku);
      final transactionIdStorage = box.read(StorageReferences.urlPaymentDoku);

      if (urlPaymentDokuStorage != null || transactionIdStorage != null) {
        box.remove(StorageReferences.urlPaymentDoku);
        box.remove(StorageReferences.urlPaymentDoku);
      }

      Get.toNamed('/home');
      Get.snackbar(
        "Success",
        "Terimakasih sudah melakukan pembayaran online",
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> getTransactionInvoiceMasyarakatQRIS(
      {required TransactionNonCash transactionNonCash}) async {
    try {
      final urlPaymentDoku = box.read(StorageReferences.urlPaymentDoku);
      if (urlPaymentDoku != null) {
        final transactionId = box.read(StorageReferences.transactionId);
        Get.to(
          () => WebViewDoku(
            url: urlPaymentDoku!,
            transactionId: transactionId!,
          ),
        );
        return;
      }

      transactionNonCash.type = "NONCASH";
      transactionNonCash.method = Method(payments: 'CHECKOUT', type: 'QRIS');

      ResponseAPI response =
          await _transactionRepositories.transactionInvoiceMasyarakatNonCash(
              transactionNonCash: transactionNonCash);

      _checkout.value = Checkout.fromJson(response.data);

      box.write(StorageReferences.urlPaymentDoku, getURLPaymentDokuQRIS);
      box.write(StorageReferences.transactionId, getTransactionId);

      Get.to(
        () => WebViewDoku(
          url: getURLPaymentDokuQRIS!,
          transactionId: getTransactionId!,
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
