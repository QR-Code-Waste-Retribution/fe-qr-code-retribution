import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:qr_code_app/services/api_client.dart';

class GeographicRepositories extends GetxService {
  final Dio _client = Client().init();

  Future getSubDistricts({required int districtId}) async {
    try {
      final response = await _client.get('/sub_district?district_id=$districtId');
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }
}