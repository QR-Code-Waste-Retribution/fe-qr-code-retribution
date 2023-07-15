import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/pages/profile/forget_password/otp_input_stage.dart';

class ForgotPasswordProvider extends GetxController {
  var emailController = TextEditingController();

  void onNextStage() {
    Get.toNamed(OtpInputStagePage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }
}
