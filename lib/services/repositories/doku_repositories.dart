import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:qr_code_app/services/api_client.dart';

class DokuRepositories extends GetxService {
  final Dio _client = Client().init(baseUrl: "");

  Future apiPayDokuDirectVirtualAccount({required String url}) async {
    try {
      final response =
          await _client.get(url);
      final jsonDecodeResponse = jsonDecode(response.toString());

      return jsonDecodeResponse;
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return jsonDecodeResponse;
    } catch (e) {
      throw Exception("Failed to get api doku : $e");
    }
  }
}
