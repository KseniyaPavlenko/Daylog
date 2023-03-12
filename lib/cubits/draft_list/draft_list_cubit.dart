import 'package:daylog/cubits/draft_list/draft_list_state.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DraftListCubit extends Cubit<DraftListState> {
  final DraftService draftService;
  final ErrorCubit errorCubit;
  DraftListCubit({required this.errorCubit, required this.draftService})
      : super(DraftListState.init());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final drafts = await draftService.list();
      emit(state.copyWith(drafts: drafts));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.common);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> deleteDraft(String draftId) async {
    emit(state.copyWith(isLoading: true));
    try {
      await draftService.delete(draftId);
      final drafts = await draftService.list();

      emit(state.copyWith(drafts: drafts));
    } catch (e) {
      // handle error
      errorCubit.showError(ErrorState.common);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
