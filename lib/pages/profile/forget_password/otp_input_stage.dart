import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/components/atoms/custom_loading.dart';
import 'package:qr_code_app/components/molekuls/appbar/i_appbar.dart';
import 'package:qr_code_app/components/molekuls/countdown/countdown.dart';
import 'package:qr_code_app/components/molekuls/input/input_otp.dart';
import 'package:qr_code_app/services/providers/otp_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/logger.dart';

class OtpInputStagePage extends StatelessWidget {
  static const routeName = '/OtpInputStagePage';

  OtpInputStagePage({super.key});

  final OtpProvider otpProvider = Get.find<OtpProvider>();
  final String email = Get.arguments['email'];

  @override
  Widget build(BuildContext context) {
    otpProvider.sendAgain.value = true;

    return Scaffold(
      appBar: IAppBar.transparent(),
      body: Obx(
        () {
          if (otpProvider.isLoading) {
            return CustomLoading(
              loadingColor: secondaryColor,
              textColor: secondaryColor,
              text: "Validasi OTP",
            );
          }
          return SafeArea(
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
                      otpProvider.onNextStage(email: email);
                    }
                  },
                  controller: otpProvider.otpInput,
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => otpProvider.isSendAgain
                      ? CountDown(
                          text: 'Kirim ulang ',
                          fontSize: 12,
                          callback: () {
                            otpProvider.sendAgain.value = false;
                          },
                        )
                      : Row(
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
                                otpProvider.send(email);
                              },
                              child: Text(
                                otpProvider.isLoading
                                    ? 'Loading...'
                                    : 'Kirim Ulang',
                                style: priceTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
