import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';

class CategoriesRepositories extends GetxService {
  final Dio _client = Client().init();

  Future allCategories({required int districtId, String? uuid}) async {
    try {
      final response = await _client.get('/category?district_id=$districtId');
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }
}
