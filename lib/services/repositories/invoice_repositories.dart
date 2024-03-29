import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_code_app/exceptions/api_exception.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:dio/dio.dart';
import 'package:qr_code_app/services/api_client.dart';

class InvoiceRepositories extends GetxService {
  final Dio _client = Client().init();

  Future invoiceUserByUUIDandSubDistrict(
      {required int subDistrictId, String? uuid, int? pemungutId}) async {
    try {
      final response = await _client.post('/people/$uuid/invoice', data: {
        "sub_district_id": subDistrictId,
        "pemungut_id": pemungutId,
      });
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      var response = ResponseAPI.fromJson(jsonDecodeResponse);

      throw ApiException(
        message: "Error",
        statusCode: ex.response?.statusCode,
        responseAPI: response,
      );
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future invoiceUserByUserId({required int userId}) async {
    try {
      final response = await _client.get('/invoice/$userId');
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future allUserForInvoicePaidAndUnpaid({required int pemungutId}) async {
    try {
      final response = await _client.get('/invoice/users/all/$pemungutId');
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }
}
