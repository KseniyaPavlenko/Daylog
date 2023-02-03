import 'package:daylog/models/event.dart';
import 'package:equatable/equatable.dart';

class EventListState with EquatableMixin {
  final bool isLoading;
  final List<Event>? events;
  final DateTime selectedDate;

  const EventListState({
    this.isLoading = false,
    this.events,
    required this.selectedDate,
  });

  List<Event> get list => events ?? [];

  EventListState copyWith({
    bool? isLoading,
    List<Event>? events,
    DateTime? selectedDate,
  }) {
    return EventListState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  factory EventListState.init() {
    final selectedDate = DateTime.now();
    return EventListState(isLoading: false, selectedDate: selectedDate);
  }

  @override
  List<Object?> get props {
    return [isLoading, events, selectedDate];
  }
}
