import 'package:daylog/cubits/me/me_state.dart';
import 'package:daylog/models/user.dart';
import 'package:daylog/services/user/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeCubit extends Cubit<MeState> {
  final UserService userService;
  MeCubit({required this.userService}) : super(MeState.init());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await userService.me();
      emit(state.copyWith(user: user));
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateUser(User user) async {
    emit(state.copyWith(isLoading: true));
    try {
      final newUser = await userService.update(user);
      emit(state.copyWith(user: newUser));
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> deleteUser() async {
    emit(state.copyWith(isLoading: true));
    try {
      await userService.delete();
      emit(state.copyWith(user: null));
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void init() {
    emit(MeState.init());
  }
}
