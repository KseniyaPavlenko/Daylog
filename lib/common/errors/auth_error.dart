import 'package:dio/dio.dart';

class AuthError extends DioError {
  AuthError({required super.requestOptions});
}
