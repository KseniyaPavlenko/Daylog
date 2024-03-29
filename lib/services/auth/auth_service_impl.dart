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

  // Paths
  static const _authPath = '/auth';
  static const _loginPath = '$_authPath/login';
  static const _signUpPath = '$_authPath/signup';

  // Keys
  static const _loginKey = 'login';
  static const _passwordKey = 'password';

  @override
  Future<Token> login(String login, String password) async {
    final response = await dio.post(
      _loginPath,
      data: {_loginKey: login, _passwordKey: password},
    );
    final token = Token.fromJson(json.decode(response.data));
    await localStorage.setToken(token.token);
    return token;
  }

  @override
  Future<User> signUp(String login, String password) async {
    final response = await dio.post(
      _signUpPath,
      data: {_loginKey: login, _passwordKey: password},
    );
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
