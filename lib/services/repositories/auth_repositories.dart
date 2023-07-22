import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/exceptions/api_exception.dart';
import 'package:qr_code_app/models/form/auth/change_password_form.dart';
import 'package:qr_code_app/models/form/auth/edit_profile_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';
import 'package:qr_code_app/utils/logger.dart';

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

  Future changePassword({
    required int userId,
    required ChangePasswordForm changePasswordForm,
  }) async {
    try {
      final response = await _client.put(
        '/user/change/$userId/password',
        data: changePasswordForm.toJson(),
      );
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);

      throw Exception(response.message.toString());
    }
  }

  Future changeForgetPassword({
    required ChangePasswordForm changePasswordForm,
  }) async {
    try {
      final response = await _client.put(
        '/user/forget-password/change',
        data: changePasswordForm.toJson(),
      );
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);
      throw Exception(response.message.toString());
    }
  }

  Future sendOTPByEmail({
    required String email,
  }) async {
    try {
      final response = await _client.post(
        '/user/forget-password',
        data: {
          'email': email,
        },
      );
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);

      throw Exception(response.message.toString());
    }
  }

  Future checkOTPByEmail({required String email, required String otp}) async {
    try {
      final response = await _client.post(
        '/user/otp/check',
        data: {
          'email': email,
          'otp_code': otp,
        },
      );
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);

      throw Exception(response.message.toString());
    }
  }

  Future saveToken({required int userId, required String token}) async {
    try {
      final response = await _client.put(
        '/notification/token/$userId',
        data: {
          'token': token,
        },
      );
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      logger.d(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);

      throw ApiException(message: response.message.toString());
    }
  }
}
