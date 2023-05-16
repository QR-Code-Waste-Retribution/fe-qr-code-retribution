import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/doku/virtual_account/api/virtual_account_payment.dart';
import 'package:qr_code_app/services/repositories/doku_repositories.dart';

class DokuProvider extends GetxController {
  final box = GetStorage();

  final DokuRepositories _dokuRepositories = DokuRepositories();

  final RxBool isLoading = false.obs;

  final Rx<VirtualAccountPayment> _virtualAccountPayment =
      VirtualAccountPayment(paymentInstruction: []).obs;

  VirtualAccountPayment get getVirtualAccountPayment =>
      _virtualAccountPayment.value;

  String? get getVirtualAccountNumber =>
      _virtualAccountPayment.value.virtualAccountInfo?.virtualAccountNumber;

  String virtualAccoutNumber() {
    String? input =
        getVirtualAccountPayment.virtualAccountInfo?.virtualAccountNumber!;

    StringBuffer output = StringBuffer();
    int count = 0;

    for (int i = 0; i < input!.length; i++) {
      if (count == 4) {
        output.write(' ');
        count = 0;
      }
      output.write(input[i]);
      count++;
    }

    return output.toString();
  }

  Future<void> getApiPayDokuDirectVirtualAccount({required String url}) async {
    try {
    var response =
        await _dokuRepositories.apiPayDokuDirectVirtualAccount(url: url);

    _virtualAccountPayment.value = VirtualAccountPayment.fromJson(response);

    isLoading.value = false;

    update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get api : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }
}
