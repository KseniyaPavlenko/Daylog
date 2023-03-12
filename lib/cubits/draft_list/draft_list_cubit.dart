import 'package:daylog/common/utils/logger.dart';
import 'package:daylog/cubits/draft_list/draft_list_state.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class DraftListCubit extends Cubit<DraftListState> {
  final DraftService draftService;
  final Logger _logger; // TODO(Kseniya): не используется или добавь вывод ошибок в консоль или удали
  final ErrorCubit errorCubit;
  DraftListCubit({required this.errorCubit, required this.draftService})
      : _logger = createLog(name: 'DraftListCubit'),
        super(DraftListState.init());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final drafts = await draftService.list();
      emit(state.copyWith(drafts: drafts));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.deafult);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  // TODO(Kseniya): Удали если уже не будешь использовать
  // Future<void> loadDataByDate(DateTime dateTime) async {
  //   emit(state.copyWith(isLoading: true));
  //   try {
  //      final drafts = await draftService.listByDate(dateTime);
  //      emit(state.copyWith(drafts: drafts));
  //   } catch (e) {
  //     // handle error
  //   } finally {
  //     emit(state.copyWith(isLoading: false));
  //   }
  // }

  Future<void> deleteDraft(String draftId) async {
    emit(state.copyWith(isLoading: true));
    try {
      await draftService.delete(draftId);
      final drafts = await draftService.list();

      emit(state.copyWith(drafts: drafts));
    } catch (e) {
      // handle error
      errorCubit.showError(ErrorState.deafult);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
