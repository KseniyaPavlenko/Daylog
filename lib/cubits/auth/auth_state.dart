import 'package:daylog/models/user.dart';
import 'package:equatable/equatable.dart';

class AuthState with EquatableMixin {
  final bool isLoading;
  final bool? isAuthorized;

  const AuthState({
    this.isLoading = false,
    this.isAuthorized,
  });

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

  factory AuthState.init() {
    return const AuthState(isLoading: false);
  }

  @override
  List<Object?> get props {
    return [isLoading, isAuthorized];
  }
}
