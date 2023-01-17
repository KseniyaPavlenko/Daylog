import 'dart:convert';

import 'package:daylog/models/user.dart';
import 'package:daylog/services/user/user_service.dart';

class UserServiceMock implements UserService {
  @override
  Future<User> me() async {
    const rawJson = '''{
  "id": "754b143d-153c-4198-aaab-31b4dd30961a",
  "login": "alex6"
}''';
    return User.fromJson(jsonDecode(rawJson));
  }

  @override
  Future<User> update(User user) async {
    return user;
  }

  @override
  Future<void> delete() async {
    throw UnimplementedError();
  }
}
