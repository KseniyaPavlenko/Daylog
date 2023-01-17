import 'package:daylog/models/event.dart';
import 'package:equatable/equatable.dart';

class EventDetailState with EquatableMixin {
  final bool isLoading;
  final bool isNew;
  final Event? selectedEvent;

  const EventDetailState({
    this.isLoading = false,
    this.selectedEvent,
    this.isNew = false,
  });

  EventDetailState copyWith({
    bool? isLoading,
    bool? isNew,
    Event? selectedEvent,
  }) {
    return EventDetailState(
      isLoading: isLoading ?? this.isLoading,
      isNew: isNew ?? this.isNew,
      selectedEvent: selectedEvent ?? this.selectedEvent,
    );
  }

  factory EventDetailState.init() {
    return const EventDetailState(isLoading: false);
  }

  @override
  List<Object?> get props {
    return [isLoading, isNew, selectedEvent];
  }
}
