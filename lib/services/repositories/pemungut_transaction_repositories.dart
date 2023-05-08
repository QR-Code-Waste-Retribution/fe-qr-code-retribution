import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:dio/dio.dart';
import 'package:qr_code_app/services/api_client.dart';


class PemungutTransactionRepositories extends GetxService {
  final Dio _client = Client().init();

  Future allPemungutTransactionByPemungutId(
      {required int pemungutId}) async {
    try {
      final response =
          await _client.get('/pemungut_transaction/$pemungutId');
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
