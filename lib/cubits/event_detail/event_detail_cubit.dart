import 'package:daylog/common/utils/logger.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/error_cubit/error_state.dart';
import 'package:daylog/cubits/event_detail/event_detail_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final EventService eventService;
  final Logger _logger;
  final ErrorCubit errorCubit;
  EventDetailCubit({required this.errorCubit, required this.eventService})
      : _logger = createLog(name: 'EventDetailCubit'),
      super(EventDetailState.init());

  Future<void> loadData(String? eventId) async {
    if (eventId == null) {
      emit(state.copyWith(selectedEvent: null, isNew: true));
      return;
    }
    emit(state.copyWith(isLoading: true, isNew: false));
    try {
      final event = await eventService.byId(eventId);
      emit(state.copyWith(selectedEvent: event));
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.deafult);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateEvent(Event event) async {
    emit(state.copyWith(isLoading: true));
    try {
      if (state.isNew) {
        final updatedEvent = await eventService.create(event);
        emit(state.copyWith(selectedEvent: updatedEvent, isNew: false));
      } else {
        final updatedEvent = await eventService.update(event);
        emit(state.copyWith(selectedEvent: updatedEvent));
      }
    } catch (error) {
      // handle error
      errorCubit.showError(ErrorState.deafult);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
