import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';

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

  bool? get isAuthenticated => _authData.value.accessToken.isNotEmpty;

  String? get userRole => _authData.value.user?.role.name;

  Future<ResponseAPI> login(
      {required String username, required String password}) async {
    ResponseAPI response = await _authRepositories.login(
      username: username,
      password: password,
    );

    _authData.value = AuthData.fromJson(response.data);
    box.write('authData', jsonEncode(authData.toJson()));
    update();

    return response;
  }

  Future<void> logout() async {
    box.remove('authData');
    _authData.value = AuthData(
        accessToken: '', credentialToken: null, tokenType: '', user: null);
    update();
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
