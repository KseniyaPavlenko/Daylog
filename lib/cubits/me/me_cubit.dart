import 'package:daylog/common/utils/logger.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:daylog/cubits/me/me_state.dart';
import 'package:daylog/models/user.dart';
import 'package:daylog/services/user/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class MeCubit extends Cubit<MeState> {
  final UserService userService;
  final Logger _logger;
  final ErrorCubit errorCubit;
  MeCubit({required this.errorCubit, required this.userService}) 
  : _logger = createLog(name: 'MeCubit'),
  
  super(MeState.init());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await userService.me();
      emit(state.copyWith(user: user));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.deafult);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateUser(User user) async {
    emit(state.copyWith(isLoading: true));
    try {
      final newUser = await userService.update(user);
      emit(state.copyWith(user: newUser));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.deafult);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> deleteUser() async {
    emit(state.copyWith(isLoading: true));
    try {
      await userService.delete();
      emit(state.copyWith(user: null));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.deafult);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void init() {
    emit(MeState.init());
  }
}
