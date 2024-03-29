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
import 'package:qr_code_app/pages/payment/non_cash/virtual_account/virtual_account_pay_page.dart';
import 'package:qr_code_app/services/repositories/transaction_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/models/transaction/transaction_noncash.dart';
import 'package:qr_code_app/models/transaction/method.dart';

class TransactionProvider extends GetxController {
  final box = GetStorage();

  final TransactionRepositories _transactionRepositories =
      TransactionRepositories();

  final Rx<TransactionInvoice> _transactionInvoice =
      TransactionInvoice(invoice: [], transaction: null).obs;

  final Rx<Transaction> _transactionWithInvoice = Transaction(invoice: []).obs;

  final Rx<TransactionList> _transactionList =
      TransactionList(transaction: [], totalAmount: 0).obs;

  final Rx<VirtualAccountDoku> _virtualAccountDoku =
      VirtualAccountDoku(order: null, virtualAccountInfo: null).obs;

  final Rx<Checkout> _checkout = Checkout(message: [], response: null).obs;

  final RxBool isLoading = false.obs;

  VirtualAccountDoku get getVirtualAccountDoku => _virtualAccountDoku.value;

  TransactionInvoice get getTransactionInvoice => _transactionInvoice.value;

  TransactionList get getTransactionList => _transactionList.value;

  Bank? get getBankVAPurchase => _virtualAccountDoku.value.bank;

  BankName? get getBankVAName => _virtualAccountDoku.value.bank?.bankName;

  int? get getTransactionId => _checkout.value.transactionId;

  String? get getURLPaymentDokuQRIS => _checkout.value.response?.payment?.url;

  String? get getURLPaymentDokuVA =>
      _virtualAccountDoku.value.virtualAccountInfo?.howToPayPage;

  String? get getURLPaymentAPIDokuVA =>
      _virtualAccountDoku.value.virtualAccountInfo?.howToPayApi;

  bool get checkURLPaymentDokuExist =>
      _virtualAccountDoku.value.virtualAccountInfo?.howToPayApi != null;

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
      isLoading.value = false;
      update();
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
      isLoading.value = false;
      update();
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
      isLoading.value = false;
      update();
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
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to get transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> getTransactionWithInvoiceByMasyarakatId(
      {int? masyarakatId}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .transactionWithInvoiceByMasyarakatId(masyarakatId: masyarakatId!);

      _transactionWithInvoice.value = Transaction.fromJson(response.data);

      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to get transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> storeTransactionInvoiceMasyarakatVirtualAccount(
      {required TransactionNonCash transactionNonCash, required typeVA}) async {
    try {
      if (!checkURLPaymentDokuExist) {
        transactionNonCash.type = "NONCASH";
        transactionNonCash.method =
            Method(payments: 'VIRTUAL_ACCOUNT', type: typeVA);

        ResponseAPI response =
            await _transactionRepositories.transactionInvoiceMasyarakatNonCash(
                transactionNonCash: transactionNonCash);

        _virtualAccountDoku.value = VirtualAccountDoku.fromJson(response.data);

        await box.write(
            StorageReferences.urlPaymentDoku, jsonEncode(getURLPaymentDokuVA));

        await box.write(
            StorageReferences.dokuBankVA, jsonEncode(getBankVAPurchase));

        await box.write(StorageReferences.expiredAtVA,
            getVirtualAccountDoku.virtualAccountInfo?.expiredDateUtc);
      }

      isLoading.value = false;

      Get.to(
        () => const VirtualAccountPayPage(),
      );

      update();
    } catch (e) {
      isLoading.value = false;
      update();
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
      ResponseAPI response =
          await _transactionRepositories.updateNonCashStatusAfterPayment(
              transactionId: transactionId, invoiceId: arrInvoiceId);

      final urlPaymentDokuStorage = box.read(StorageReferences.urlPaymentDoku);
      final transactionIdStorage = box.read(StorageReferences.urlPaymentDoku);

      if (urlPaymentDokuStorage != null || transactionIdStorage != null) {
        box.remove(StorageReferences.urlPaymentDoku);
        box.remove(StorageReferences.urlPaymentDoku);
      }

      isLoading.value = false;

      Get.toNamed('/home');
      Get.snackbar(
        "Success",
        response.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to update transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> storeTransactionInvoiceMasyarakatQRIS(
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
      isLoading.value = false;

      box.write(StorageReferences.urlPaymentDoku, getURLPaymentDokuQRIS);
      box.write(StorageReferences.transactionId, getTransactionId);
      box.write(StorageReferences.invoiceId,
          transactionNonCash.lineItems?.map((e) => e.invoiceId).join(','));

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
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        'Failed to store transaction QRIS : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  @override
  void onInit() {
    final urlPaymentDoku = box.read(StorageReferences.urlPaymentDoku);
    final dokuBankVA = box.read(StorageReferences.dokuBankVA);
    final expiredVA = box.read(StorageReferences.expiredAtVA);

    if (dokuBankVA != null) {
      _virtualAccountDoku.value.virtualAccountInfo?.createdDateUtc = expiredVA;
    }

    if (dokuBankVA != null) {
      _virtualAccountDoku.value.bank = Bank.fromJson(jsonDecode(dokuBankVA));
    }

    if (urlPaymentDoku != null) {
      _virtualAccountDoku.value.virtualAccountInfo?.howToPayApi =
          urlPaymentDoku;
    }
    update();
    super.onInit();
  }
}
