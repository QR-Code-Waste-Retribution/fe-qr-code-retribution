import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class SnackBarCustom {
  static SnackbarController success({required String message}) {
    return Get.snackbar(
      "Success",
      message,
      backgroundColor: primaryColor,
      colorText: Colors.white,
      borderRadius: 5,
    );
  }

  static SnackbarController error({required String message}) {
    return Get.snackbar(
      "Failed",
      message,
      backgroundColor: redColor,
      colorText: Colors.white,
      borderRadius: 5,
    );
    ;
  }
}
