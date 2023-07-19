import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/models/form/auth/change_password_form.dart';
import 'package:qr_code_app/models/form/auth/edit_profile_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/binding.dart';
// import 'package:qr_code_app/services/providers/pagination_provider.dart';
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

  int? get getUserId => _authData.value.user?.id;

  AuthData get authData => _authData.value;

  String? get getUUID => _authData.value.user?.uuid;

  int? get subDistrictId => _authData.value.user?.subDistrictId;

  int? get districtId => _authData.value.user?.districtId;

  bool? get isAuthenticated => _authData.value.accessToken.isNotEmpty;

  String? get userRole => _authData.value.user?.role?.name;

  String? get userName => _authData.value.user?.name;

  String? get userPhoneNumber => _authData.value.user?.phoneNumber;

  String? get userAddress => _authData.value.user?.address;

  String? get userSubDistrict => _authData.value.user?.subDistrict?.name;

  String? get userSubDistrictId =>
      _authData.value.user?.subDistrict?.id.toString();

  bool checkAuth() {
    final authDataJson = box.read('authData');
    if (authDataJson != null) {
      return true;
    }
    return false;
  }

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

        Get.offNamed('/home');
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
      Get.deleteAll();
      Get.put(AuthProvider());
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

  Future<void> getUserData() async {
    try {
      final authDataJson = box.read('authData');
      if (authDataJson != null) {
        _authData.value = AuthData.fromJson(jsonDecode(authDataJson));
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> editProfile(
      {required int userId, required EditProfileForm editProfileForm}) async {
    try {
      ResponseAPI response = await _authRepositories.editProfile(
        userId: userId,
        editProfileForm: editProfileForm,
      );

      User userUpdated = User.fromJson(response.data);
      final authDataJson = box.read('authData');

      if (authDataJson != null) {
        Map<String, dynamic> authDataMap = jsonDecode(authDataJson);
        authDataMap['user'] = userUpdated.toJson();

        _authData.value = AuthData.fromJson(authDataMap);
        update();
        box.write('authData', jsonEncode(authDataMap));
        Get.offAndToNamed(Pages.homePage);
      }

      Get.snackbar(
        "Success",
        response.message,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 5,
      );

      update();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyimpan data : ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 5,
      );
    }
  }

  Future<void> changePassword(
      {required int userId,
      required ChangePasswordForm changePasswordForm}) async {
    try {
      ResponseAPI response = await _authRepositories.changePassword(
        userId: userId,
        changePasswordForm: changePasswordForm,
      );

      SnackBarCustom.success(message: response.message);
      update();
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
    }
  }

  @override
  void onReady() {
    final authDataJson = box.read('authData');
    if (authDataJson != null) {
      _authData.value = AuthData.fromJson(jsonDecode(authDataJson));
      update();
    }
    super.onReady();
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
}
