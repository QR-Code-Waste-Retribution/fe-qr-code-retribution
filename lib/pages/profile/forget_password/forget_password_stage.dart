import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/components/molekuls/appbar/i_appbar.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';
import 'package:qr_code_app/components/molekuls/input/input_group_custom.dart';
import 'package:qr_code_app/services/providers/auth/forgot_password_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  ForgotPasswordProvider forgotPasswordProvider =
      Get.find<ForgotPasswordProvider>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: IAppBar.transparent(
        onTapLeading: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Text(
              'Lupa Password',
              style: secondaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Silahkan masukkan email/No. telepon anda yang masih aktif dan terdaftar di aplikasi retribusi sampah kabupaten Toba',
              textAlign: TextAlign.center,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => InputGroupCustom(
                errorText: forgotPasswordProvider.getErrorMessages['email'],
                onChanged: (value) {
                  forgotPasswordProvider.onChangeInputEmail();
                },
                hintText: 'Email',
                required: true,
                inputController: forgotPasswordProvider.emailInput,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => forgotPasswordProvider.isLoading
                  ? CustomLoading(
                      loadingColor: secondaryColor,
                      textColor: secondaryColor,
                    )
                  : CustomButton(
                      title: 'Selanjutnya',
                      width: 120,
                      height: 45,
                      fontSize: 14,
                      defaultRadiusButton: 10,
                      onPressed: () {
                        forgotPasswordProvider.onNextStage();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
