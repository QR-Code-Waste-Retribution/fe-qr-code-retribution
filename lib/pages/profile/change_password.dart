import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/services/providers/auth/change_password_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';

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
          InputGroup(
            hintText: "Kata Sandi Lama",
            obscure: true,
            required: true,
            inputController: changePasswordProvider.oldPasswordInput,
          ),
          InputGroup(
            hintText: "Kata Sandi Baru",
            obscure: true,
            required: true,
            inputController: changePasswordProvider.newPasswordInput,
          ),
          InputGroup(
            hintText: "Konfirmasi Kata Sandi Baru",
            obscure: true,
            required: true,
            inputController: changePasswordProvider.confirmPasswordInput,
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
