import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/form/edit_profile_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';

class AuthRepositories extends GetxService {
  final Dio _client = Client().init();

  Future<ResponseAPI> login(
      {required String username, required String password}) async {
    try {
      final response = await _client.post('/login', data: {
        "username": username,
        "password": password,
      });
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }

  Future editProfile(
      {required int userId, required EditProfileForm editProfileForm}) async {
    try {
      final response = await _client.put(
        '/user/edit/$userId/profile',
        data: editProfileForm.toJson(),
      );
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }
}
