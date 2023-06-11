import 'package:dio/dio.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';

class Client {
  Dio init({String baseUrl = AppConstants.apiUrlLocal}) {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.contentType = 'application/json';
    return dio;
  }

  // Future<Shared

  Options get authorizationHeader {
    var token;
    return Options(headers: {
      "Authorization": "Bearer $token",
      "accept": "application/json"
    });
  }
}
