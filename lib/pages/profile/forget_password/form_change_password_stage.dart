import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/appbar/i_appbar.dart';
import 'package:qr_code_app/services/providers/auth/change_password_provider.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';
import 'package:qr_code_app/shared/theme/init.dart';

import '../../../components/molekuls/input/input_group_custom.dart';

class FormChangePassword extends StatelessWidget {
  static const routeName = '/FormChangePassword';

  FormChangePassword({super.key});

  final ChangePasswordProvider changePasswordProvider =
      Get.find<ChangePasswordProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar.transparent(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  'Lupa Password',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Obx(
                  () => InputGroupCustom(
                    hintText: "Password baru",
                    required: true,
                    obscure: true,
                    inputController: changePasswordProvider.newPasswordInput,
                    onChanged: (value) {
                      changePasswordProvider.onChangeNewPasswordInput();
                    },
                    errorText:
                        changePasswordProvider.getNewPasswordInputErrorText,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => InputGroupCustom(
                    hintText: "Konfirmasi Password baru",
                    required: true,
                    obscure: true,
                    inputController:
                        changePasswordProvider.confirmPasswordInput,
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
                  width: double.infinity,
                  height: 40,
                  backgroundColor: secondaryColor,
                  fontSize: 14,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
