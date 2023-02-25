import 'package:daylog/common/errors/auth_error.dart';
import 'package:daylog/common/utils/logger.dart';
import 'package:daylog/cubits/auth/auth_state.dart';
import 'package:daylog/models/daylog_error.dart';
import 'package:daylog/services/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  final Logger _logger;

  AuthCubit({required this.authService})
      : _logger = createLog(name: 'AuthCubit'),
        super(AuthState.init());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final isAuthorized = await authService.isAuthorized();
      emit(state.copyWith(isAuthorized: isAuthorized));
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> login(String login, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      await authService.login(login, password);
      emit(state.copyWith(isAuthorized: true));
    } catch (error) {
      if (error is AuthError) {
        emit(state.updateError(DaylogError.authError));
      } else {
        _logger.e(error.toString());
        emit(state.updateError(DaylogError.deafultError));
      }
    } finally {
      emit(state.copyWith(isLoading: false).updateError());
    }
  }

  Future<void> signup(String login, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      await authService.signup(login, password);
      await authService.login(login, password);
      emit(state.copyWith(isAuthorized: true));
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));
    try {
      await authService.logout();
      emit(state.copyWith(isAuthorized: false));
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void init() {
    emit(AuthState.init());
  }
}
