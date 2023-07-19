import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/input/input_group_custom.dart';
import 'package:qr_code_app/services/providers/auth/change_password_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final ChangePasswordProvider changePasswordProvider =
      Get.find<ChangePasswordProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: (() {
            Get.back();
          }),
        ),
        title: Text(
          "Ganti Kata Sandi",
          style: primaryTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: whiteColor,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CustomHeader(
            text: 'Ganti Kata Sandi',
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => InputGroupCustom(
              hintText: "kata sandi lama",
              required: true,
              obscure: true,
              inputController: changePasswordProvider.oldPasswordInput,
              onChanged: (value) {
                changePasswordProvider.onChangeOldPasswordInput();
              },
              errorText: changePasswordProvider.getOldPasswordInputErrorText,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => InputGroupCustom(
              hintText: "Kata sandi baru",
              required: true,
              obscure: true,
              inputController: changePasswordProvider.newPasswordInput,
              onChanged: (value) {
                changePasswordProvider.onChangeNewPasswordInput();
              },
              errorText: changePasswordProvider.getNewPasswordInputErrorText,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => InputGroupCustom(
              hintText: "Konfirmasi kata sandi baru",
              required: true,
              obscure: true,
              inputController: changePasswordProvider.confirmPasswordInput,
              onChanged: (value) {
                changePasswordProvider.onChangeConfirmPasswordInput();
              },
              errorText:
                  changePasswordProvider.getConfirmPasswordInputErrorText,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            title: 'Simpan',
            width: 120,
            height: 45,
            fontSize: 14,
            defaultRadiusButton: 10,
            onPressed: () {
              changePasswordProvider.onSubmit();
            },
          ),
        ],
      ),
    );
  }
}
