import 'package:daylog/cubits/draft_detail/draft_detail_state.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DraftDetailCubit extends Cubit<DraftDetailState> {
  final ErrorCubit errorCubit;
  final DraftService draftService;
  DraftDetailCubit({required this.errorCubit, required this.draftService})
      : super(DraftDetailState.init());

  Future<void> loadData(String? draftId) async {
    if (draftId == null) {
      emit(state.copyWith(selectedDraft: null, isNew: true));
      return;
    }
    emit(state.copyWith(isLoading: true, isNew: false));
    try {
      final draft = await draftService.byId(draftId);
      emit(state.copyWith(selectedDraft: draft));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.common);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateDraft(Draft draft) async {
    emit(state.copyWith(isLoading: true));
    try {
      if (state.isNew) {
        final updatedDraft = await draftService.create(draft);
        emit(state.copyWith(selectedDraft: updatedDraft, isNew: false));
      } else {
        final updatedDraft = await draftService.update(draft);
        emit(state.copyWith(selectedDraft: updatedDraft));
      }
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.common);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void init() {
    emit(DraftDetailState.init());
  }
}
