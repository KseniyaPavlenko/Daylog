import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/me/me_cubit.dart';
import 'package:daylog/cubits/me/me_state.dart';
import 'package:daylog/models/user.dart';
import 'package:daylog/services/user/user_service_mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Me Cubit', () {
    late MeCubit meCubit;

    setUp((() {
      meCubit = MeCubit(
        userService: UserServiceMock(),
        errorCubit: ErrorCubit(),
      );
    }));

    test('Get me', () async {
      // Given

      // When
      // meCubit.loadData();

      // Then
      const expectUser = User(
        id: '754b143d-153c-4198-aaab-31b4dd30961a',
        login: 'alex6',
      );

      expect(meCubit.state, const MeState(isLoading: false));
      expectLater(
        meCubit.stream,
        emitsInOrder([
          const MeState(isLoading: true),
          const MeState(isLoading: true, user: expectUser),
          const MeState(isLoading: false, user: expectUser),
        ]),
      );

      // When
      await meCubit.loadData();
      // await meCubit.loadData();
      // expectLater(
      //     meCubit.state, const MeState(isLoading: false, user: expectUser));

      expect(meCubit.state, const MeState(isLoading: false, user: expectUser));
    });

    test('Update me', () async {
      // Given

      // When
      // meCubit.loadData();

      // Then

      const newUser = User(
        id: '754b143d-153c-4198-aaab-31b4dd30961a',
        login: 'alex7',
        password: null,
      );

      expect(meCubit.state, const MeState(isLoading: false));
      expectLater(
        meCubit.stream,
        emitsInOrder([
          const MeState(isLoading: true, user: null),
          const MeState(isLoading: true, user: newUser),
          const MeState(isLoading: false, user: newUser),
        ]),
      );

      // When
      await meCubit.updateUser(newUser);
    });

    test('Delete me', () async {
      // Given

      // When
      // meCubit.loadData();

      // Then

      /*  const deletedUser = User(
        id: '754b143d-153c-4198-aaab-31b4dd30961a',
        login: 'alex6',
        password: null,
      ); */

      expect(meCubit.state, const MeState(isLoading: false));
      expectLater(
        meCubit.stream,
        emitsInOrder([
          const MeState(isLoading: true),
          const MeState(isLoading: false, user: null)
        ]),
      );

      // When
      await meCubit.deleteUser();
    });
  });
}
