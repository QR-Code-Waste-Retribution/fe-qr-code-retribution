import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:qr_code_app/models/response_api.dart';

class InvoiceProvider {
  Dio _client;

  InvoiceProvider(this._client);

  Future getInvoiceUser({required int subDistrictId, String? uuid}) async {
    try {
      final response = await _client.post('/people/$uuid/invoice', data: {
        "sub_district_id": subDistrictId,
      });
      final jsonDecodeResponse = jsonDecode(response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    }
  }
}
