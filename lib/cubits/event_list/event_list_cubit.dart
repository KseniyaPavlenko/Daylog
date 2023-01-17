import 'package:daylog/cubits/event_list/event_list_state.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventListCubit extends Cubit<EventListState> {
  final EventService eventService;
  EventListCubit({required this.eventService}) : super(EventListState.init());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final events = await eventService.list(state.selectedDate);
      emit(state.copyWith(events: events));
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateDate(DateTime date) async {
    emit(state.copyWith(isLoading: true));
    try {
      final events = await eventService.list(state.selectedDate);
      emit(state.copyWith(events: events, selectedDate: date));
    } catch (e) {
      // handle error
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
    } catch (e) {
      // handle error
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
