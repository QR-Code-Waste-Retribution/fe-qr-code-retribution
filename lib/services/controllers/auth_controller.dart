import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/pages/login_page.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';
import 'package:qr_code_app/shared/theme/init.dart';

class AuthController {
  final AuthProvider _authProvider = AuthProvider();

  void checkAuth() {
    if (!_authProvider.isAuthenticated!) {
      Get.offAll(() => const LoginPage());
    }
  }

  String? getName(){
    return _authProvider.authData.user?.name;
  }

  Future<void> login({required String username, required String password}) async {
    try {
      ResponseAPI responseAPI = await _authProvider.login(username: username, password: password);
      Get.offAllNamed('/home');
      Get.snackbar(
        "Success",
        responseAPI.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );
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
      await _authProvider.logout();
      Get.offAll(() => const LoginPage());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
