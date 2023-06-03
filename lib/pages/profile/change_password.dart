import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/components/atoms/custom_header.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

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
            setState(() {
              Get.back();
            });
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
            inputController: oldPasswordController,
          ),
          InputGroup(
            hintText: "Kata Sandi Baru",
            obscure: true,
            required: true,
            inputController: newPasswordController,
          ),
          InputGroup(
            hintText: "Konfirmasi Kata Sandi Baru",
            obscure: true,
            required: true,
            inputController: confirmPasswordController,
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
