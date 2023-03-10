import 'package:bloc_test/bloc_test.dart';
import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/cubits/event_list/event_list_state.dart';
import 'package:daylog/services/draft/draft_service_mock.dart';
import 'package:daylog/services/event/event_service_mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event List Cubit', () {
    final resultEventList = EventServiceMock.mockedEventList();
    final today = DateTime.now();
    const eventId = '6c250a66-ad54-4c9d-a089-0df5cd0aa188';
    final resultEventListWithDeletedItem =
        resultEventList.where((e) => e.id != eventId).toList();

    blocTest(
      'Get list of events',
      build: () => EventListCubit(eventService: EventServiceMock(), draftService: DraftServiceMock()),
      seed: () => EventListState(selectedDate: today),
      act: (bloc) => bloc.loadData(),
      expect: () => [
        EventListState(isLoading: true, selectedDate: today),
        EventListState(
            isLoading: true, selectedDate: today, events: resultEventList),
        EventListState(
            isLoading: false, selectedDate: today, events: resultEventList),
      ],
    );
    blocTest(
      'Delete event from list',
      build: () => EventListCubit(eventService: EventServiceMock(), draftService: DraftServiceMock()),
      seed: () => EventListState(selectedDate: today, events: resultEventList),
      act: (bloc) => bloc.deleteEvent(eventId),
      expect: () => [
        EventListState(
            isLoading: true, selectedDate: today, events: resultEventList),
        EventListState(
            isLoading: true,
            selectedDate: today,
            events: resultEventListWithDeletedItem),
        EventListState(
            isLoading: false,
            selectedDate: today,
            events: resultEventListWithDeletedItem),
      ],
    );
  });
}
