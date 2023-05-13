import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/transaction/transaction_pemungut.dart';
import 'package:qr_code_app/services/repositories/pemungut_transaction_repositories.dart';

class PemungutTransactionProvider extends GetxController {
  final box = GetStorage();

  final PemungutTransactionRepositories _transactionRepositories =
      PemungutTransactionRepositories();

  final Rx<TransactionPemungut> depositList =
      TransactionPemungut(deposit: []).obs;

  final RxBool isLoading = false.obs;

  final RxInt alreadyDeposited = 0.obs;
  final RxInt notYetDeposited = 0.obs;

  int get getTotalIncome => alreadyDeposited.value + notYetDeposited.value;

  void depositCalc() {
    alreadyDeposited.value = 0;
    notYetDeposited.value = 0;
    
    for (var deposit in depositList.value.deposit!) {
      if (deposit.status == 1) {
        alreadyDeposited.value += deposit.price?.normalPrice as int;
        continue;
      }
      notYetDeposited.value += deposit.price?.normalPrice as int;
    }
  }

  Future<void> getAllPemungutTransactionByPemungutId(
      {required int? pemungutId}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .allPemungutTransactionByPemungutId(pemungutId: pemungutId!);

      depositList.value = TransactionPemungut.fromJson(response.data);
      depositCalc();
      isLoading.value = false;
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get pemungut transaction : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
