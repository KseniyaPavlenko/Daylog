import 'package:daylog/common/net/dio_interceptor.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:daylog/services/event/event_service_impl.dart';
import 'package:daylog/services/local_storage/local_storage_mock.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event Service', () {
    late EventService eventService;
    late LocalStorageMock localStorage;

    setUp((() {
      final dio = Dio();
      dio.options.baseUrl = 'http://localhost:8080/api/v1';

      localStorage = LocalStorageMock();
      localStorage.setToken('login=ksenia4');

      dio.interceptors.add(DioInterceptor(localStorage));
      // dio.interceptors.add(_TokenAddInterceptor());
      eventService = EventServiceImpl(
        dio: dio,
      );
    }));

    test('get list check', () async {
      const date = '2022-08-03';
      final list = await eventService.list(DateTime.parse(date));
      expect(list, isNotEmpty);
    });

    test('get list by id check', () async {
      const id = '8f23049e-5c3a-4306-8f67-4dbdbb6b478e';
      final event = await eventService.byId(id);
      expect(event, isNotNull);
      expect(event.id, id);
    });

    test('create event check', () async {
      final event = Event.fromJson({
        "startDate": "2022-08-03",
        "startAt": "2022-07-03 19:10:25",
        "duration": 60,
        "title": "Task2",
        "detail": "details2",
        "comment": "hello"
      });
      final newEvent = await eventService.create(event);
      expect(newEvent, isNotNull);
      expect(newEvent.id, isNotNull);
      expect(newEvent.startDate, event.startDate);
    });

    test('update event check', () async {
      final draftEvent = Event.fromJson({
        "startDate": "2022-08-03",
        "startAt": "2022-07-03 19:10:25",
        "duration": 60,
        "title": "Task2",
        "detail": "details2",
        "comment": "hello"
      });
      final newEvent = await eventService.create(draftEvent);
      const updatedTitle = 'updated title';
      const updatedDuration = 30;

      final updatedEvent = await eventService.update(newEvent.copyWith(
        title: updatedTitle,
        duration: updatedDuration,
      ));
      expect(updatedEvent.id, newEvent.id);
      expect(updatedEvent.title, updatedTitle);
      expect(updatedEvent.duration, updatedDuration);
    });

    test('delete event check', () async {
      final draftEvent = Event.fromJson({
        "startDate": "2022-08-03",
        "startAt": "2022-07-03 19:10:25",
        "duration": 60,
        "title": "Task2",
        "detail": "details2",
        "comment": "hello"
      });
      final newEvent = await eventService.create(draftEvent);
      final id = newEvent.id!;
      await eventService.delete(id);
      expectLater(eventService.delete(id), throwsException);
      expectLater(eventService.byId(id), throwsException);
    });
  });
}
