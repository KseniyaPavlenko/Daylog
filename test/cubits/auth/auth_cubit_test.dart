import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/auth/auth_state.dart';
import 'package:daylog/services/auth/auth_service_mock.dart';
import 'package:test/test.dart';

void main() {
  group('Auth Cubit', () {
    late AuthCubit authCubit;

    setUp((() {
      authCubit = AuthCubit(authService: AuthServiceMock());
    }));

    test('Get me', () async {
      // Given

      // When

      // Then
      // const expectUser = User(
      //  id: '754b143d-153c-4198-aaab-31b4dd30961a',
      //  login: 'alex6',
      //);

      expect(authCubit.state, const AuthState(isLoading: false));
      expectLater(
        authCubit.stream,
        emitsInOrder([
          const AuthState(isLoading: true),
          const AuthState(isLoading: true, isAuthorized: false),
          const AuthState(isLoading: false, isAuthorized: false),
        ]),
      );

      // When
      await authCubit.loadData();

      /* expectLater(authCubit.state,
          const AuthState(isLoading: false, isAuthorized: true)); */
    });

    test('Login', () async {
      // Given

      // When

      // Then
      String login = 'login';
      String password = 'password';
      expect(authCubit.state, const AuthState(isLoading: false));
      expectLater(
        authCubit.stream,
        emitsInOrder([
          const AuthState(isLoading: true),
          const AuthState(isLoading: true, isAuthorized: true),
          const AuthState(isLoading: false, isAuthorized: true),
        ]),
      );

      // When
      await authCubit.login(login, password);

      /* expectLater(authCubit.state,
          const AuthState(isLoading: false, isAuthorized: true)); */
    });

    test('Signup', () async {
      // Given

      // When

      // Then
      String login = 'login1';
      String password = 'password1';
      expect(authCubit.state, const AuthState(isLoading: false));
      expectLater(
        authCubit.stream,
        emitsInOrder([
          const AuthState(isLoading: true),
          const AuthState(isLoading: true, isAuthorized: true),
          const AuthState(isLoading: false, isAuthorized: true),
        ]),
      );

      // When
      await authCubit.signup(login, password);

      /* expectLater(authCubit.state,
          const AuthState(isLoading: false, isAuthorized: true)); */
    });

    test('Logout', () async {
      // Given

      // When

      // Then
      String login = 'login1';
      String password = 'password1';

      expect(authCubit.state, const AuthState(isLoading: false));
      expectLater(
        authCubit.stream,
        emitsInOrder([
          const AuthState(isLoading: true),
          const AuthState(isLoading: true, isAuthorized: true),
          const AuthState(isLoading: false, isAuthorized: true),
          const AuthState(isLoading: true, isAuthorized: true),
          const AuthState(isLoading: true, isAuthorized: false),
          const AuthState(isLoading: false, isAuthorized: false),
        ]),
      );

      // When
      await authCubit.signup(login, password);
      await authCubit.logout();

      /* expectLater(authCubit.state,
          const AuthState(isLoading: false, isAuthorized: true)); */
    });

    /*  blocTest<AuthCubit, void>(
      'emits [] when nothing is called',
      build: () => AuthCubit(),
      expect: () => const <void>[],
    );

    blocTest<CounterCubit, int>(
      'emits [1] when increment is called',
      build: () => CounterCubit(),
      act: (cubit) => cubit.increment(),
      expect: () => const <int>[1],
    ); */
  });
}
