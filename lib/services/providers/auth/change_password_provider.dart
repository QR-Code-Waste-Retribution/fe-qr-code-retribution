import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/form/auth/change_password_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/utils/logger.dart';

class ChangePasswordProvider extends GetxController {
  final AuthProvider authProvider = Get.find<AuthProvider>();

  final AuthRepositories authRepositories = Get.find<AuthRepositories>();

  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  TextEditingController get oldPasswordInput => oldPasswordController.value;
  TextEditingController get newPasswordInput => newPasswordController.value;
  TextEditingController get confirmPasswordInput =>
      confirmPasswordController.value;

  RxString newPasswordInputErrorText = ''.obs;
  RxString confirmPasswordInputErrorText = ''.obs;

  String get getNewPasswordInputErrorText => newPasswordInputErrorText.value;
  String get getConfirmPasswordInputErrorText =>
      confirmPasswordInputErrorText.value;

  void onSubmit() async {
    if (oldPasswordInput.text == '' ||
        newPasswordInput.text == '' ||
        confirmPasswordInput.text == '') {
      SnackBarCustom.error(message: 'Semua input harus diisi');
      return;
    }

    if (newPasswordInput.text != confirmPasswordInput.text) {
      SnackBarCustom.error(message: 'Konfirmasi sandi baru harus sama');
      return;
    }

    try {
      ResponseAPI response = await authRepositories.changePassword(
        userId: authProvider.getUserId!,
        changePasswordForm: ChangePasswordForm(
          oldPassword: oldPasswordInput.text,
          newPassword: newPasswordInput.text,
          confirmPassword: confirmPasswordInput.text,
        ),
      );
      SnackBarCustom.success(message: response.message);
      update();
      Get.offAndToNamed(Pages.homePage);
    } on Exception catch (e) {
      SnackBarCustom.error(message: e.toString());
    }
  }

  void onChangeNewPasswordInput() {
    if (newPasswordInput.text == '') {
      newPasswordInputErrorText.value = "Input password harus diisi";
    } else {
      newPasswordInputErrorText.value = "";
    }
  }

  void onChangeConfirmPasswordInput() {
    if (confirmPasswordInput.text == '') {
      confirmPasswordInputErrorText.value =
          "Input Konfirmasi password harus diisi";
    } else if (confirmPasswordInput.text != newPasswordInput.text) {
      confirmPasswordInputErrorText.value = "Password tidak sama";
    } else {
      confirmPasswordInputErrorText.value = "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.value.dispose();
    newPasswordController.value.dispose();
    confirmPasswordController.value.dispose();
  }
}
