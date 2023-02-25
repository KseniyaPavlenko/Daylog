import 'package:daylog/models/daylog_error.dart';
import 'package:daylog/models/user.dart';
import 'package:equatable/equatable.dart';

class AuthState with EquatableMixin {
  final bool isLoading;
  final bool? isAuthorized;
  final DaylogError? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthorized,
    this.error,
  });

  bool get hasError => error != null;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthorized,
    User? currentUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthorized: isAuthorized ?? this.isAuthorized,
    );
  }

  AuthState updateError([DaylogError? error]) {
    return AuthState(
      isLoading: isLoading,
      isAuthorized: isAuthorized,
      error: error,
    );
  }

  factory AuthState.init() {
    return const AuthState(isLoading: false);
  }

  @override
  List<Object?> get props {
    return [isLoading, isAuthorized, error];
  }
}
