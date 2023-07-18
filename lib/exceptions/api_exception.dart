import 'package:qr_code_app/models/response_api.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final ResponseAPI? responseAPI;

  ApiException({required this.message, this.statusCode = 400, this.responseAPI});

  @override
  String toString() {
    return 'ApiException: $message (Status Code: $statusCode)';
  }
}
