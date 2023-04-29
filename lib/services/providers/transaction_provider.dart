import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/transaction/transaction_invoice.dart';
import 'package:qr_code_app/models/transaction/transaction_list.dart';
import 'package:qr_code_app/models/transaction/transaction_store.dart';
import 'package:qr_code_app/services/repositories/transaction_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class TransactionProvider extends GetxController {
  final TransactionRepositories _transactionRepositories =
      TransactionRepositories();

  final Rx<TransactionInvoice> _transactionInvoice =
      TransactionInvoice(invoice: [], transaction: null).obs;

  final Rx<TransactionList> _transactionList =
      TransactionList(transaction: []).obs;

  final RxBool isLoading = false.obs;

  TransactionInvoice get getTransactionInvoice => _transactionInvoice.value;

  TransactionList get getTransactionList => _transactionList.value;

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
    // try {
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
    // } catch (e) {
    //   Get.snackbar(
    //     'Error',
    //     'Failed to get transaction : ${e.toString()}',
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //     borderRadius: 5,
    //   );
    // }
  }
}
