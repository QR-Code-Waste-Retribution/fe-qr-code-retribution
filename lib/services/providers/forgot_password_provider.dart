import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/pages/profile/forget_password/otp_input_stage.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';

class ForgotPasswordProvider extends GetxController {
  final AuthRepositories _authRepositories = AuthRepositories();

  Rx<TextEditingController> emailController = TextEditingController().obs;

  TextEditingController get emailInput => emailController.value;

  RxBool loading = false.obs;

  bool get isLoading => loading.value;

  void onNextStage() async {
    try {
      loading.value = true;
      update();
      
      ResponseAPI response = await _authRepositories.sendOTPByEmail(
        email: emailInput.text,
      );

      loading.value = false;
      SnackBarCustom.success(message: response.message);

      Get.toNamed(OtpInputStagePage.routeName, arguments: {
        'email': emailInput.text,
      });

      update();
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailInput.dispose();
  }
}
