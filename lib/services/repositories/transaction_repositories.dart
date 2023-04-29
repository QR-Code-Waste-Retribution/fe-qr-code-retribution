import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:dio/dio.dart';
import 'package:qr_code_app/models/transaction/transaction_store.dart';
import 'package:qr_code_app/services/api_client.dart';

class TransactionRepositories extends GetxService {
  final Dio _client = Client().init();

  Future transactionInvoiceMasyarakat(
      {required TransactionStore transactionStore}) async {
    try {
      final response =
          await _client.post('/transaction', data: transactionStore.toJson());
      final jsonDecodeResponse = jsonDecode(response.toString());

      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioError catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future transactionByMasyarakatId({required int masyarakatId}) async {
    try {
      final response =
          await _client.get('/transaction/masyarakat/$masyarakatId');
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
