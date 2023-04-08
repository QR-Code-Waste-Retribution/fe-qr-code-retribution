import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/models/user.dart';
import 'package:qr_code_app/services/repositories/auth_repositories.dart';

class AuthProvider extends GetxController {
  final AuthRepositories _authRepositories = AuthRepositories();

  final box = GetStorage();

  AuthData _authData = AuthData(
    accessToken: '',
    credentialToken: null,
    tokenType: '',
    user: null,
  );

  AuthData get authData => _authData;

  bool? get isAuthenticated => _authData.accessToken.isNotEmpty;

  String? get userRole => _authData.user?.role.name;

  Future<ResponseAPI> login(
      {required String username, required String password}) async {
    ResponseAPI response = await _authRepositories.login(
      username: username,
      password: password,
    );

    _authData = AuthData.fromJson(response.data);
    box.write('authData', jsonEncode(authData.toJson()));
    update();
    return response;
  }

  Future<void> logout() async {
    box.remove('authData');
    _authData = AuthData(
        accessToken: '', credentialToken: null, tokenType: '', user: null);
    update();
  }

  @override
  void onInit() {
    final authDataJson = box.read('authData');
    if (authDataJson != null) {
      _authData = AuthData.fromJson(jsonDecode(authDataJson));
      update();
    }
    super.onInit();
  }
}
