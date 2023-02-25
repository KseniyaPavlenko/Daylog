import 'dart:convert';

import 'package:daylog/models/token.dart';
import 'package:daylog/models/user.dart';
import 'package:daylog/services/auth/auth_service.dart';
import 'package:daylog/services/local_storage/local_storage.dart';
import 'package:dio/dio.dart';

class AuthServiceImpl implements AuthService {
  final Dio dio;
  final LocalStorage localStorage;

  AuthServiceImpl({
    required this.dio,
    required this.localStorage,
  });

  @override
  Future<Token> login(String login, String password) async {
    final response = await dio.post('/auth/login', data: {
      'login': login,
      'password': password,
    });
    final token = Token.fromJson(jsonDecode(response.data));
    await localStorage.setToken(token.token);
    return token;
  }

  @override
  Future<User> signup(String login, String password) async {
    final response = await dio.post('/auth/signup', data: {
      'login': login,
      'password': password,
    });
    return User.fromJson(jsonDecode(response.data));
  }

  @override
  Future<bool> isAuthorized() async {
    final token = await localStorage.getToken();
    return token != null;
  }

  @override
  Future<void> logout() async {
    await localStorage.setToken(null);
  }
}
