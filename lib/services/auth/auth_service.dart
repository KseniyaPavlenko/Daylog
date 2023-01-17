import 'package:daylog/models/token.dart';
import 'package:daylog/models/user.dart';

abstract class AuthService {
  Future<Token> login(String login, String password);

  Future<User> signup(String login, String password);

  Future<bool> isAuthorized();

  Future<void> logout();
}
