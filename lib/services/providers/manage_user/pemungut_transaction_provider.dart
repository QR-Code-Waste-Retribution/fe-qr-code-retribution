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

  final Rx<TransactionPemungut> depositList = TransactionPemungut(
          deposits: [], depositArreas: '', depositCalculation: null)
      .obs;

  final RxBool isLoading = false.obs;

  TransactionPemungut get getAllDeposit => depositList.value;

  int get getTotalIncome => getAlreadyDeposited()! + getNotYetDeposited()!;

  bool get getDataExist =>
      depositList.value.deposits?.length != null ? true : false;

  int? getAlreadyDeposited() {
    return depositList.value.depositCalculation?.alreadyDeposited!;
  }

  int? getNotYetDeposited() {
    return depositList.value.depositCalculation?.notYetDeposited!;
  }

  Future<void> getAllPemungutTransactionByPemungutId(
      {required int? pemungutId}) async {
    try {
      ResponseAPI response = await _transactionRepositories
          .allPemungutTransactionByPemungutId(pemungutId: pemungutId!);

      depositList.value = TransactionPemungut.fromJson(response.data);
      isLoading.value = false;
      update();
    } catch (e) {

      isLoading.value = false;
      update();
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
