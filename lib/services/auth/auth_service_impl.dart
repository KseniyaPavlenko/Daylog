import 'dart:convert';

import 'package:daylog/models/token.dart';
import 'package:daylog/models/user.dart';
import 'package:daylog/services/auth/auth_service.dart';
import 'package:dio/dio.dart';

import '../local_storage/local_storage.dart';

class AuthServiceImpl implements AuthService {
  final Dio dio;
  final LocalStorage localStorage;

  AuthServiceImpl({
    required this.dio,
    required this.localStorage,
  });

  @override
  Future<Token> login(String login, String password) async {
    final response = await dio.post('/auth/login');
    final token = Token.fromJson(jsonDecode(response.data));
    localStorage.token = token.token;
    return token;
  }

  @override
  Future<User> signup(String login, String password) async {
    final response = await dio.post('/auth/signup');
    return User.fromJson(jsonDecode(response.data));
  }

  @override
  Future<bool> isAuthorized() async {
    return localStorage.token != null;
  }

  @override
  Future<void> logout() async {
    await dio.post('/auth/logout');
    localStorage.token = null;
  }
}
