import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/utils/logger.dart';

class OtpProvider extends GetxController {
  var otpController = TextEditingController();

  void onNextStage() {
    logger.d(otpController.text);
  }

  void send() {
    emptyInput();
  }

  void emptyInput() {
    otpController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }
}
