import 'dart:convert';

import 'package:daylog/models/user.dart';
import 'package:daylog/services/user/user_service.dart';
import 'package:dio/dio.dart';

class UserServiceImpl implements UserService {
  final Dio dio;

  UserServiceImpl({
    required this.dio,
  });

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<User> me() async {
    final response = await dio.get('/me');
    final user = User.fromJson(jsonDecode(response.data));
    return user;
  }

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<User> update(User user) async {
    final response = await dio.put('/me', data: jsonEncode(user.toJson()));
    final updatedUser = User.fromJson(jsonDecode(response.data));
    return updatedUser;
  }

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<void> delete() async {
    await dio.delete('/me');
  }
}
