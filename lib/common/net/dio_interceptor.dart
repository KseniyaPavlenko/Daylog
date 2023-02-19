// ignore_for_file: avoid_print

import 'package:daylog/common/errors/auth_error.dart';
import 'package:daylog/common/errors/request_error.dart';
import 'package:daylog/services/local_storage/local_storage.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final LocalStorage localStorage;

  DioInterceptor(this.localStorage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    if (isTokenRequired(options)) {
      Map<String, dynamic> headers = Map.from(options.headers);
      final token = await localStorage.getToken();
      headers['Authorization'] = 'Bearer $token';
      handler.next(options.copyWith(headers: headers));
      return;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    final code = response.statusCode ?? 500;

    if (code >= 200 && code < 300) {
      handler.next(response);
      return;
    }

    if (code == 400) {
      handler.reject(RequestError(requestOptions: response.requestOptions));
      return;
    }

    if (code == 401) {
      handler.reject(AuthError(requestOptions: response.requestOptions));
      return;
    }

    handler.reject(DioError(requestOptions: response.requestOptions));
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    handler.next(err);
  }

  bool isTokenRequired(RequestOptions options) {
    return !(options.path.contains('/auth/login') ||
        options.path.contains('/auth/signup'));
  }
}
