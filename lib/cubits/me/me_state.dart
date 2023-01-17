import 'package:daylog/models/user.dart';
import 'package:equatable/equatable.dart';

class MeState with EquatableMixin {
  final bool isLoading;
  final User? user;

  const MeState({
    this.isLoading = false,
    this.user,
  });

  MeState copyWith({
    bool? isLoading,
    User? user,
  }) {
    return MeState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }

  factory MeState.init() {
    return const MeState(isLoading: false);
  }

  @override
  List<Object?> get props {
    return [isLoading, user];
  }
}
