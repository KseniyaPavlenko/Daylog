import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/cubits/event_detail/event_detail_cubit.dart';
import 'package:daylog/cubits/event_detail/event_detail_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/services/event/event_service_mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event Detail Cubit', () {
    late EventDetailCubit eventDetailCubit;
    setUp((() {
      eventDetailCubit = EventDetailCubit(
        eventService: EventServiceMock(),
        errorCubit: ErrorCubit(),
      );
    }));

    test(
      'Get event',
      () async {
        // Given

        // When

        // Then
        // Event event = Event(id: '6c250a66-ad54-4c9d-a089-0df5cd0aa188');

        expect(
            eventDetailCubit.state, const EventDetailState(isLoading: false));
        expectLater(
          eventDetailCubit.stream,
          emitsInOrder([
            const EventDetailState(isLoading: true),
            EventDetailState(
                isLoading: true,
                isNew: false,
                selectedEvent: EventServiceMock.mockEvent1()),
            EventDetailState(
                isLoading: false,
                isNew: false,
                selectedEvent: EventServiceMock.mockEvent1()),
          ]),
        );

        // When
        await eventDetailCubit.loadData(EventServiceMock.eventId1);
      },
    );

    test('Update event', () async {
      // Given

      // When

      // Then
      Event event = Event(id: '5a1101fa-8361-40ed-9a6b-b9eda6b1595b');
      //Event updatedEvent = Event(id: '5a1101fa-8361-40ed-9a6b-b9eda6b1595b');

      expect(eventDetailCubit.state, const EventDetailState(isLoading: false));
      expectLater(
        eventDetailCubit.stream,
        emitsInOrder([
          const EventDetailState(
              isLoading: false, isNew: true, selectedEvent: null),
          // const EventDetailState(isLoading: true, isNew: true),
          //const EventDetailState(isLoading: false, isNew: true),
        ]),
      );

      // When
      await eventDetailCubit.loadData(null);
      await eventDetailCubit.updateEvent(event);

      expect(eventDetailCubit.state.selectedEvent, isA<Event>());
    });
  });
}
