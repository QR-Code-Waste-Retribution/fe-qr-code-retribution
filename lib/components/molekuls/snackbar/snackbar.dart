import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class SnackBarCustom {
  static SnackbarController success({required String message}) {
    return Get.snackbar(
      "Berhasil",
      message,
      backgroundColor: primaryColor,
      colorText: Colors.white,
      borderRadius: 5,
    );
  }

  static SnackbarController error({required String message}) {
    return Get.snackbar(
      "Gagal",
      message,
      backgroundColor: redColor,
      colorText: Colors.white,
      borderRadius: 5,
    );
  }
}
