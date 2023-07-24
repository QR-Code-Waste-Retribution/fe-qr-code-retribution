import 'package:dio/dio.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/core/constants/storage.dart';

class Client {
  Dio init({String baseUrl = AppConstants.apiUrlLocal}) {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.contentType = 'application/json';
    dio.options.headers = authorizationHeader.headers;

    return dio;
  }

  // Future<Shared

  Options get authorizationHeader {
    String accessToken = StorageReferences.getAuthToken();
    return Options(headers: {
      "Authorization": "Bearer $accessToken",
      "accept": "application/json"
    });
  }
}
