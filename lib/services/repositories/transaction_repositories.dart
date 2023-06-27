import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_code_app/models/response_api.dart';
import 'package:dio/dio.dart';
import 'package:qr_code_app/models/transaction/transaction_noncash.dart';
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
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future transactionAdditionalMasyarakat(
      {required TransactionStore transactionStore}) async {
    try {
      final response = await _client.post('/transaction/store/additional',
          data: transactionStore.toJson());
      final jsonDecodeResponse = jsonDecode(response.toString());

      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future transactionInvoiceMasyarakatNonCash(
      {required TransactionNonCash transactionNonCash}) async {
    try {
      final response = await _client.post('/transaction/store/non-cash',
          data: transactionNonCash.toJson());
      final jsonDecodeResponse = jsonDecode(response.toString());
;

      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
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
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future allTransactionByPemungutId({required int pemungutId}) async {
    try {
      final response = await _client.get('/transaction/pemungut/$pemungutId');
      final jsonDecodeResponse = jsonDecode(response.toString());

      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future updateNonCashStatusAfterPayment(
      {required int transactionId, required List<int?> invoiceId}) async {
    try {
      final response = await _client.put(
          '/transaction/update/non-cash/status/$transactionId',
          data: {"invoice_id": invoiceId});
      final jsonDecodeResponse = jsonDecode(response.toString());

      return ResponseAPI.fromJson(jsonDecodeResponse);
    } on DioException catch (ex) {
      final jsonDecodeResponse = jsonDecode(ex.response.toString());
      return ResponseAPI.fromJson(jsonDecodeResponse);
    } catch (e) {
      throw Exception("Failed to get invoice user: $e");
    }
  }

  Future transactionWithInvoiceByMasyarakatId(
      {required int masyarakatId}) async {
    try {
      final response = await _client.get('/transaction/$masyarakatId');
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
