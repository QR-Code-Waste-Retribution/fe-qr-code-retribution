import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/form/auth/change_password_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/providers/auth/auth_provider.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';

class ChangePasswordProvider extends GetxController {

  final AuthRepositories authRepositories = Get.find<AuthRepositories>();

  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  TextEditingController get oldPasswordInput => oldPasswordController.value;
  TextEditingController get newPasswordInput => newPasswordController.value;
  TextEditingController get confirmPasswordInput =>
      confirmPasswordController.value;

  RxString oldPasswordInputErrorText = ''.obs;
  RxString newPasswordInputErrorText = ''.obs;
  RxString confirmPasswordInputErrorText = ''.obs;

  String get getOldPasswordInputErrorText => oldPasswordInputErrorText.value;
  String get getNewPasswordInputErrorText => newPasswordInputErrorText.value;
  String get getConfirmPasswordInputErrorText =>
      confirmPasswordInputErrorText.value;

  RxBool valid = false.obs;
  bool get isValid => valid.value;

  void onSubmit({ required int userId }) async {
    if (!isValid) {
      onChangeNewPasswordInput();
      onChangeConfirmPasswordInput();
      onChangeOldPasswordInput();

      SnackBarCustom.error(message: 'Pastikan semua input valid');
      return;
    }

    try {
      ResponseAPI response = await authRepositories.changePassword(
        userId: userId,
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

  void forgetPassword({required String email}) async {
    onChangeNewPasswordInput();
    onChangeConfirmPasswordInput();
    if (!isValid) {
      SnackBarCustom.error(message: 'Semua input harus diisi');
      return;
    }

    try {
      ResponseAPI response = await authRepositories.changeForgetPassword(
        changePasswordForm: ChangePasswordForm(
          email: email,
          newPassword: newPasswordInput.text,
          confirmPassword: confirmPasswordInput.text,
        ),
      );
      SnackBarCustom.success(message: response.message);
      update();
      Get.offAndToNamed(Pages.loginPage);
    } on Exception catch (e) {
      SnackBarCustom.error(message: e.toString());
    }
  }

  void onChangeNewPasswordInput() {
    if (newPasswordInput.text == '') {
      valid.value = false;
      newPasswordInputErrorText.value = "Kata sandi baru harus diisi";
    } else {
      valid.value = true;
      newPasswordInputErrorText.value = "";
    }
    update();
  }

  void onChangeConfirmPasswordInput() {
    if (confirmPasswordInput.text == '') {
      valid.value = false;
      confirmPasswordInputErrorText.value = "Konfirmasi kata sandi harus diisi";
    } else if (confirmPasswordInput.text != newPasswordInput.text) {
      valid.value = false;
      confirmPasswordInputErrorText.value = "Kata sandi tidak sama";
    } else {
      valid.value = true;
      confirmPasswordInputErrorText.value = "";
    }
    update();
  }

  void onChangeOldPasswordInput() {
    if (oldPasswordInput.text == '') {
      valid.value = false;
      oldPasswordInputErrorText.value = "Kata sandi harus diisi";
    } else {
      valid.value = true;
      oldPasswordInputErrorText.value = "";
    }
    update();
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.value.dispose();
    newPasswordController.value.dispose();
    confirmPasswordController.value.dispose();
  }
}
