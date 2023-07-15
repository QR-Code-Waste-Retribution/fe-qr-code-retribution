import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/molekuls/appbar/i_appbar.dart';
import 'package:qr_code_app/components/molekuls/input/input_otp.dart';
import 'package:qr_code_app/services/providers/otp_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/logger.dart';

class OtpInputStagePage extends StatelessWidget {
  static const routeName = '/OtpInputStagePage';

  OtpInputStagePage({super.key});

  final OtpProvider otpProvider = Get.find<OtpProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IAppBar.transparent(),
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
              'Kami telah mengirimkan kode OTP ke email yang anda masukkan',
              textAlign: TextAlign.center,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Ketikkan OTP",
              style: secondaryTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            InputOTP.primary(
              onSubmitted: (String value) {
                logger.d("message 1 $value");
              },
              onChanged: (String value) {
                if (value.length == 6) {
                  otpProvider.onNextStage();
                }
              },
              controller: otpProvider.otpController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tidak menerima kode OTP?',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    otpProvider.send();
                  },
                  child: Text(
                    'Kirim Ulang',
                    style: priceTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
