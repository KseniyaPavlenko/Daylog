import 'dart:convert';

import 'package:daylog/models/token.dart';
import 'package:daylog/models/user.dart';
import 'package:daylog/services/auth/auth_service.dart';

class AuthServiceMock implements AuthService {
  bool _isAuthorized = false;
  @override
  Future<Token> login(String login, String password) async {
    _isAuthorized = true;
    return Token.fromJson(jsonDecode('''{
        "token": "sdfsdfsdf"
    }
'''));
  }

  @override
  Future<User> signUp(String login, String password) async {
    const rawJson = '''{
  "id": "e6bf616f-dd75-4214-89f6-97b3ad1f205c",
  "login": "ksenia3"
}''';
    return User.fromJson(jsonDecode(rawJson));
  }

  @override
  Future<bool> isAuthorized() async {
    return _isAuthorized;
  }

  @override
  Future<void> logout() async {
    _isAuthorized = false;
  }
}
