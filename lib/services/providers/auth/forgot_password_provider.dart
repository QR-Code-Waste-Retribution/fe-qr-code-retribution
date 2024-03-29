import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/pages/profile/forget_password/otp_input_stage.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/utils/logger.dart';

class ForgotPasswordProvider extends GetxController {
  final AuthRepositories _authRepositories = AuthRepositories();

  Rx<TextEditingController> emailController = TextEditingController().obs;

  TextEditingController get emailInput => emailController.value;

  RxBool loading = false.obs;

  RxMap<String, String> errorMessages = <String, String>{
    'email': '',
  }.obs;

  Map<String, String> get getErrorMessages => errorMessages;

  void onChangeInputEmail() {
    if (emailInput.value.text == '') {
      errorMessages['email'] = "Input email harus diisi";
    } else {
      errorMessages['email'] = "";
    }
    update();
  }

  bool get isLoading => loading.value;

  void onNextStage() async {
    try {
      loading.value = true;
      update();

      ResponseAPI response = await _authRepositories.sendOTPByEmail(
        email: emailInput.text,
      );
      SnackBarCustom.success(message: response.message);

      loading.value = false;
      update();

      Get.toNamed(OtpInputStagePage.routeName, arguments: {
        'email': emailInput.text,
      });
    } catch (e) {
      loading.value = false;
      update();
      SnackBarCustom.error(message: e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailInput.dispose();
  }
}
