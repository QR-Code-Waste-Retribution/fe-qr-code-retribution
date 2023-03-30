import 'package:dio/dio.dart';


class Client {
  Dio init() {
    Dio dio = Dio();
    // dio.interceptors.add(ApiInterceptors());
    dio.options.baseUrl = "http://localhost:8000/api";
    dio.options.contentType = 'application/json';
    return dio;
  }

  // Future<Shared

  Options get authorizationHeader {
    var token;
    return Options(
      headers: {
        "Authorization" : "Bearer $token",
        "accept": "application/json"
      }
    );
  }
}
