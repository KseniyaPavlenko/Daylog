import 'dart:convert';

import 'package:daylog/common/net/dio_interceptor.dart';
import 'package:daylog/models/token.dart';
import 'package:daylog/services/auth/auth_service.dart';
import 'package:daylog/services/auth/auth_service_impl.dart';
import 'package:daylog/services/local_storage/local_storage_mock.dart';
import 'package:daylog/services/user/user_service.dart';
import 'package:daylog/services/user/user_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('Auth Service', () {
    late AuthService authService;
    late UserService userService;
    late LocalStorageMock localStorage;

    setUp((() {
      final dio = Dio();
      dio.options.baseUrl = 'http://localhost:8080/api/v1';

      localStorage = LocalStorageMock();
      localStorage.setToken('login=ksenia4');

      dio.interceptors.add(DioInterceptor(localStorage));
      // dio.interceptors.add(_TokenAddInterceptor());
      authService = AuthServiceImpl(
        dio: dio,
        localStorage: localStorage,
      );

      userService = UserServiceImpl(
        dio: dio,
      );
    }));

    test('Login check', () async {
      //token
      final token = await authService.login('ksenia4', '123');
      expect(token.token, isNotNull);
      expect(token.token, isNotEmpty);
    });

    test('SignUp check', () async {
      const login = 'ksenia_test_user_01';
      const password = '1234';
      final token = await authService.signUp(login, password);
      expect(token.login, isNotNull);
      expect(token.password, isNull);
      expect(token.id, isNotNull);
      await authService.login(login, password);
      await userService.delete();
    });

    test('isAuth check', () async {
      //bool
      // final token = await authService.isAuthorized();
      //expect(true, isNotNull);
      //expect(token, 'token');
    });

    test('Logout check', () async {
      final token = await authService.login('ksenia4', '123');
      expect(token.token, isNotNull);
      expect(token.token, isNotEmpty);

      await authService.logout();
      expect(await localStorage.getToken(), isNull);
    });
  });
}

class LoginInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.resolve(Response(
      requestOptions: options,
      data: jsonEncode(Token(token: 'token').toJson()),
    ));
  }
}
