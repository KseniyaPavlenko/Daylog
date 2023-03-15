import 'dart:convert';

import 'package:daylog/models/user.dart';
import 'package:daylog/services/user/user_service.dart';
import 'package:dio/dio.dart';

class UserServiceImpl implements UserService {
  final Dio dio;

  UserServiceImpl({
    required this.dio,
  });

    // Paths
  static const _mePath = '/me';

  @override
  Future<User> me() async {
    final response = await dio.get(_mePath);
    final user = User.fromJson(jsonDecode(response.data));
    return user;
  }

  @override
  Future<User> update(User user) async {
    final response = await dio.put(_mePath, data: jsonEncode(user.toJson()));
    final updatedUser = User.fromJson(jsonDecode(response.data));
    return updatedUser;
  }

  @override
  Future<void> delete() async {
    await dio.delete(_mePath);
  }
}
