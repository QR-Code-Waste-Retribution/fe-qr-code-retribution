import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/pages/profile/forget_password/form_change_password_stage.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';

class OtpProvider extends GetxController {
  final AuthRepositories _authRepositories = AuthRepositories();

  Rx<TextEditingController> otpController = TextEditingController().obs;

  TextEditingController get otpInput => otpController.value;

  RxBool sendAgain = false.obs;
  RxBool loading = false.obs;
  RxBool loadingSend = false.obs;

  bool get isSendAgain => sendAgain.value;
  bool get isLoading => loading.value;
  bool get isLoadingSend => loadingSend.value;

  void onNextStage({required String email}) async {
    try {
      loading.value = true;
      update();
      ResponseAPI response = await _authRepositories.checkOTPByEmail(
        otp: otpInput.text,
        email: email,
      );

      SnackBarCustom.success(message: response.message);
      Get.toNamed(FormChangePassword.routeName, arguments: {
        'email': email,
      });
      loading.value = false;
      update();
    } catch (e) {
      loading.value = false;
      update();
      SnackBarCustom.error(message: e.toString());
    }
  }

  void send(String email) async {
    emptyInput();
    try {
      loadingSend.value = true;
      update();

      ResponseAPI response = await _authRepositories.sendOTPByEmail(
        email: email,
      );

      SnackBarCustom.success(message: response.message);
      sendAgain.value = true;
      loadingSend.value = false;
      update();
    } catch (e) {
      update();
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
