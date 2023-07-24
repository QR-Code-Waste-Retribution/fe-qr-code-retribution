import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_code_app/components/molekuls/snackbar/snackbar.dart';
import 'package:qr_code_app/core/constants/storage.dart';
import 'package:qr_code_app/core/firebase/firebase_provider.dart';
import 'package:qr_code_app/exceptions/api_exception.dart';
import 'package:qr_code_app/models/form/auth/change_password_form.dart';
import 'package:qr_code_app/models/form/auth/edit_profile_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user/user.dart';
import 'package:qr_code_app/routes/init.dart';
import 'package:qr_code_app/services/binding.dart';
// import 'package:qr_code_app/services/providers/pagination_provider.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';
import 'package:qr_code_app/shared/theme/init.dart';
import 'package:qr_code_app/utils/logger.dart';

class AuthProvider extends GetxController {
  final AuthRepositories _authRepositories = AuthRepositories();
  final FirebaseProvider firebaseProvider = FirebaseProvider();

  final box = GetStorage();

  final Rx<AuthData> _authData = AuthData(
    accessToken: '',
    credentialToken: null,
    tokenType: '',
    user: null,
  ).obs;

  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  RxMap<String, String> errorMessages = <String, String>{
    'username': '',
    'password': '',
  }.obs;

  Map<String, String> get getErrorMessages => errorMessages;

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

  void onChangeInputUsername() {
    errorMessages['username'] = "";
    update();
  }

  void onChangeInputPassword() {
    errorMessages['password'] = "";
    update();
  }

  bool checkAuth() {
    final authDataJson = box.read('authData');
    if (authDataJson != null) {
      return true;
    }
    return false;
  }

  void saveToken() async {
    final fcmToken = box.read(StorageReferences.fcmToken);
    String token = await FirebaseProvider.setupToken();

    if (fcmToken != null) {
      if (fcmToken != token) {
        await _authRepositories.saveToken(
          userId: _authData.value.user!.id!,
          token: token,
        );
        logger.d('Token has stored to database!!');
      } else {
        logger.d('Token match!!');
      }
      box.write(StorageReferences.fcmToken, token);
    } else {
      await _authRepositories.saveToken(
        userId: _authData.value.user!.id!,
        token: token,
      );
      logger.d('Token has stored to database!!');
    }
  }

  bool validation() {
    bool isValid = true;
    if (usernameController.value.text == '') {
      isValid = false;
      errorMessages['username'] = "Username harus diisi";
    }

    if (passwordController.value.text == '') {
      isValid = false;
      errorMessages['password'] = "Password harus diisi";
    }

    update();
    return isValid;
  }

  Future<void> login() async {
    try {
      if (!(validation())) {
        return;
      }
      ResponseAPI response = await _authRepositories.login(
        username: usernameController.value.text,
        password: passwordController.value.text,
      );
      if (response.success) {
        _authData.value = AuthData.fromJson(response.data);
        box.write('authData', jsonEncode(authData.toJson()));

        saveToken();
        Get.offNamed(Pages.homePage);

        SnackBarCustom.success(message: response.message);
      } else {
        SnackBarCustom.error(message: response.message);
      }

      AppBindings().dependencies();
      update();
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
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
      SnackBarCustom.error(message: e.toString());
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
      SnackBarCustom.error(message: e.toString());
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

      SnackBarCustom.success(message: response.message);

      update();
    } catch (e) {
      SnackBarCustom.error(message: e.toString());
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

  Future<void> downloadQRCode() async {
    var response = await _authRepositories.downloadQRCode();
    Uint8List uint8List = base64Decode(response);
    final result = await ImageGallerySaver.saveImage(uint8List, quality: 100);

    if (result['isSuccess']) {
      SnackBarCustom.success(message: 'Berhasil mendownload gambar');
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
  void dispose() {
    super.dispose();
    usernameController.value.dispose();
    passwordController.value.dispose();
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
