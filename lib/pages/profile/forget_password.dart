import 'package:flutter/material.dart';
import 'package:qr_code_app/components/atoms/custom_button.dart';
import 'package:qr_code_app/components/molekuls/input/input_group.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  var emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            InputGroup(
              hintText: 'Email/ No. telepon',
              required: true,
              inputController: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              title: 'Selanjutnya',
              width: 120,
              height: 45,
              fontSize: 14,
              defaultRadiusButton: 10,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
