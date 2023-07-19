import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/exceptions/api_exception.dart';
import 'package:qr_code_app/models/form/user_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';
import 'package:qr_code_app/models/form/auth/user_categories_form.dart';

class UserRepositories extends GetxService {
  final Dio _client = Client().init();

  Future getAllUserMasyarakat({required int pemungutId, int page = 1}) async {
    try {
      final response = await _client.get('/user/all/$pemungutId?page=$page');
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }

  Future registerUser({required UserForm userForm}) async {
    try {
      final response = await _client.post('/user/add', data: userForm.toJson());
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);

      throw ApiException(
          message: "Error",
          statusCode: ex.response?.statusCode,
          responseAPI: response);
    }
  }

  Future changeStatusSelectedMasyarakat({required int userId}) async {
    try {
      final response = await _client.put('/user/status/change', data: {
        'user_id': userId,
      });
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }

  Future changeMasyarakatData({
    required int userId,
    required UserCategoriesForm user,
  }) async {
    try {
      final response = await _client.put(
        '/user/edit/$userId',
        data: user.toJson(),
      );
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);

      throw ApiException(
          message: "Error",
          statusCode: ex.response?.statusCode,
          responseAPI: response);
    }
  }

  Future getDetailMasyarakat({required int userId}) async {
    try {
      final response = await _client.get('/user/$userId');
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }
}
