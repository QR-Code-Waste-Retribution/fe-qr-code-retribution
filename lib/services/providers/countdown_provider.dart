import 'dart:async';

import 'package:get/get.dart';

class CountDownProvider extends GetxController {
  Rx<Timer> countdownTimer = Timer(const Duration(seconds: 60), () { }).obs;
  // DateTime expiredDate;
}
