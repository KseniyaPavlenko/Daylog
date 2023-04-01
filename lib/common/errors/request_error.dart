import 'dart:convert';

import 'package:dio/dio.dart';

class RequestError extends DioError {
  late String _message;

  @override
  String get message => _message;

  RequestError({required super.requestOptions}) {
    // parse
    try {
      //final raw = jsonDecode(requestOptions.data);
      final dynamic raw = jsonDecode(requestOptions.data);
      final errors = raw['errors'] as Map<String, String>;
      _message = errors[errors.keys.first] ?? 'Request error';
    } catch (e) {
      _message = 'Request error';
    }
  }
}
