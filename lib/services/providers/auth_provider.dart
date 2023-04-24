import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/services/binding.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class AuthProvider extends GetxController {
  final AuthRepositories _authRepositories = AuthRepositories();

  final box = GetStorage();

  final Rx<AuthData> _authData = AuthData(
    accessToken: '',
    credentialToken: null,
    tokenType: '',
    user: null,
  ).obs;

  RxBool isLoading = false.obs;

  bool get getLoading => isLoading.value;

  AuthData get authData => _authData.value;

  int? get subDistrictId => _authData.value.user?.subDistrictId;

  bool? get isAuthenticated => _authData.value.accessToken.isNotEmpty;

  String? get userRole => _authData.value.user?.role.name;

  Future<void> login(
      {required String username, required String password}) async {
    try {
      ResponseAPI response = await _authRepositories.login(
        username: username,
        password: password,
      );
      if (response.success) {
        _authData.value = AuthData.fromJson(response.data);
        box.write('authData', jsonEncode(authData.toJson()));
        Get.toNamed('/home');
        Get.snackbar(
          "Success",
          response.message,
          backgroundColor: primaryColor,
          colorText: Colors.white,
          borderRadius: 5,
        );
      } else {
        Get.snackbar(
          "Failed",
          response.message,
          backgroundColor: redColor,
          colorText: Colors.white,
          borderRadius: 5,
        );
      }
      AppBindings().dependencies();
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to login ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> logout() async {
    try {
      box.remove('authData');
      Get.offAllNamed('/');
      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    final authDataJson = box.read('authData');
    if (authDataJson != null) {
      _authData.value = AuthData.fromJson(jsonDecode(authDataJson));
      update();
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
