import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/form/user_form.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';

class UserRepositories extends GetxService {
  final Dio _client = Client().init();

  Future getAllUserMasyarakat(
      {required int subDistrictId, required int pemungutId}) async {
    try {
      final response = await _client
          .get('/user/all/$pemungutId?sub_district_id=$subDistrictId');
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }

  Future registerUser({required UserForm userForm}) async {
    try {
      final response = await _client.post('/user/add', data: userForm.toJson());
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }

  Future changeStatusSelectedMasyarakat({required int userId}) async {
    try {
      final response = await _client.put('/user/status/change', data: {
        'user_id': userId,
      });
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }
}
