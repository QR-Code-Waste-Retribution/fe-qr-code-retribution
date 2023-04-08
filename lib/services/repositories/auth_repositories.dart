import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';
import 'package:qr_code_app/services/providers/auth_provider.dart';

class AuthRepositories {
  Client client = Client();
  late AuthProvider authProvider;

  AuthRepositories() {
    authProvider = AuthProvider(client.init());
  }

  Future<ResponseAPI> login({required String username, required String password}) async {
    ResponseAPI loginResponse =
        await authProvider.login(username: username, password: password);
    return loginResponse;
  }
}
