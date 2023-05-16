import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class CountDown extends StatefulWidget {
  final String? expiredDateAPI;
  const CountDown({super.key, required this.expiredDateAPI });

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with WidgetsBindingObserver {
  late Timer countdownTimer;
  late DateTime expiredDate;

  String countdownText = '';

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    startCountdown();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      await box.write('expired_date', expiredDate.toString());
    }
  }

  void startCountdown() {
    String? expiredDateString = box.read('expired_date');
    if (expiredDateString != null) {
      expiredDate = DateTime.parse(expiredDateString);
    } else {
      expiredDate = DateTime.now().add(const Duration(days: 30));
      box.write('expired_date', expiredDate.toString());
    }

    Duration remainingDuration = expiredDate.difference(DateTime.now());
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingDuration.isNegative) {
        countdownTimer.cancel();
        print('Perform any necessary actions when the countdown ends');
        return;
      }

      setState(() {
        int hours = remainingDuration.inHours;
        int minutes = remainingDuration.inMinutes.remainder(60);
        int seconds = remainingDuration.inSeconds.remainder(60);

        String countDownString =
            '$hours Jam : ${minutes.toString().padLeft(2, '0')} Menit : ${seconds.toString().padLeft(2, '0')} Detik';
        countdownText = countDownString;
      });

      remainingDuration = expiredDate.difference(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Pembayaran dalam $countdownText",
        style: whiteTextStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: redColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
