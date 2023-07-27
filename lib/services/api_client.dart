import 'package:dio/dio.dart';
import 'package:qr_code_app/core/constants/app_constants.dart';
import 'package:qr_code_app/core/constants/storage.dart';

class Client {
  Dio init({String baseUrl = AppConstants.apiUrlLocal}) {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.contentType = 'application/json';
    dio.options.headers = authorizationHeader.headers;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          if (e.response?.statusCode == 401) {
            if (e.response?.data['message'] == 'Unauthenticated.') {
              e.response?.data = null;
              e.response?.data = {
                'success': false,
                'data': [],
                'message': 'Sesi anda telah habis'
              };
            }
            StorageReferences.backToLogin();
          }
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  // Future<Shared

  Options get authorizationHeader {
    String accessToken = StorageReferences.getAuthToken();
    return Options(headers: {
      "Authorization": "Bearer $accessToken",
      "accept": "application/json"
    });
  }
}
