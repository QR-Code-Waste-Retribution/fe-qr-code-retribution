import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:dio/dio.dart';
import 'package:qr_code_app/services/api_client.dart';

class InvoiceRepositories extends GetxService{

  final Dio _client = Client().init();

  Future invoiceUserByUUIDandSubDistrict({required int subDistrictId, String? uuid}) async {
    try {
      final response = await _client.post('/people/$uuid/invoice', data: {
        "sub_district_id": subDistrictId,
      });
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future invoiceUserByUserId({required int userId}) async {
    try { 
      final response = await _client.get('/invoice/$userId');
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
