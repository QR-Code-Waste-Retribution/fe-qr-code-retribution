import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';

class AuthRepositories {
  final Dio _client = Client().init();

  Future login({required String username, required String password}) async {
    try {
      final response = await _client.post('/login', data: {
        "username": username,
        "password": password,
      });
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }
}
