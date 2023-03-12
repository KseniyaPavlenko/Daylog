import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:daylog/cubits/event_list/event_list_state.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventListCubit extends Cubit<EventListState> {
  final EventService eventService;
  final DraftService draftService;
  final ErrorCubit errorCubit;

  EventListCubit({
    required this.errorCubit,
    required this.draftService,
    required this.eventService,
  })  : 
        super(EventListState.init());

  Future<void> loadData([bool withDraft = false]) async {
    emit(state.copyWith(isLoading: true));
    try {
      List<Event> events = [];
      List<Draft> drafts = [];
      await Future.wait([
        eventService.list(state.selectedDate).then((result) => events = result),
        draftService.list().then((result) => drafts = result),
      ]);

      drafts
        ..where((draft) => state.selectedDate.isBetween(draft.startAt, draft.endDate))
        ..forEach((draft) => events.add(draft.toEvent));

      emit(state.copyWith(events: events));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.common);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateDate(DateTime date) async {
    emit(state.copyWith(isLoading: true));
    try {
      final events = await eventService.list(date);
      emit(state.copyWith(events: events, selectedDate: date));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.common);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> deleteEvent(String eventId) async {
    emit(state.copyWith(isLoading: true));
    try {
      await eventService.delete(eventId);
      final events = await eventService.list(state.selectedDate);

      emit(state.copyWith(events: events));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.common);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
