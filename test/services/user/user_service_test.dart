import 'package:daylog/common/net/dio_interceptor.dart';
import 'package:daylog/models/user.dart';
import 'package:daylog/services/auth/auth_service.dart';
import 'package:daylog/services/auth/auth_service_impl.dart';
import 'package:daylog/services/local_storage/local_storage_mock.dart';
import 'package:daylog/services/user/user_service.dart';
import 'package:daylog/services/user/user_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('User Service', () {
    late AuthService authService;
    late UserService userService;
    late LocalStorageMock localStorage;

    setUp((() {
      final dio = Dio();
      dio.options.baseUrl = 'http://localhost:8080/api/v1';

      localStorage = LocalStorageMock();

      localStorage.setToken('login=ksenia4');
      dio.interceptors.add(DioInterceptor(localStorage));
      authService = AuthServiceImpl(
        dio: dio,
        localStorage: localStorage,
      );

      userService = UserServiceImpl(
        dio: dio,
      );
    }));

    test('Get user', () async {
      localStorage.setToken('login=ksenia4');
      final user = await userService.me();
      expect(user.login, 'ksenia4');
      expect(user.password, isNull);
    });

    test('Update user', () async {
      localStorage.setToken('login=ksenia4');
      const newUser = User(login: 'ksenia55', password: '1234');
      final updatedUser = await userService.update(newUser);
      expect(updatedUser.login, newUser.login);
      localStorage.setToken('login=ksenia55');
      await userService.update(const User(login: 'ksenia4', password: '123'));
    });

    test('Create user', () async {
      const login = 'ksenia_test_user_002';
      const password = '1234';
      await authService.signUp(login, password);
      localStorage.setToken('login=$login');
      await userService.delete();
    });
  });
}
