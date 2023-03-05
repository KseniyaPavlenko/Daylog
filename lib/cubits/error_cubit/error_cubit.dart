import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorCubit extends Cubit<ErrorState> {
  ErrorCubit() : super(ErrorState.empty);

  void showError(ErrorState errorState) => emit(errorState);

  void clearError() => emit(ErrorState.empty);
}
