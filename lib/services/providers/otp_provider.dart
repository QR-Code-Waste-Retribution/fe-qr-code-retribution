import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/utils/logger.dart';

class OtpProvider extends GetxController {
  final AuthRepositories _authRepositories = AuthRepositories();

  Rx<TextEditingController> otpController = TextEditingController().obs;

  TextEditingController get otpInput => otpController.value;

  RxBool sendAgain = false.obs;
  RxBool loading = false.obs;

  bool get isSendAgain => sendAgain.value;
  bool get isLoading => loading.value;

  void onNextStage({required String email}) async {
    try {
      ResponseAPI response = await _authRepositories.checkOTPByEmail(
        otp: otpInput.text,
        email: email,
      );

      SnackBarCustom.success(message: response.message);

      update();
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
    }
  }

  void send(String email) async {
    emptyInput();
    try {
      loading.value = true;
      update();

      ResponseAPI response = await _authRepositories.sendOTPByEmail(
        email: email,
      );

      SnackBarCustom.success(message: response.message);
      loading.value = false;
      update();
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
    }
  }

  void emptyInput() {
    otpInput.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    otpInput.dispose();
  }
}
