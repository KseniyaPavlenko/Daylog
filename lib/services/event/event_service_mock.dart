import 'dart:convert';

import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:uuid/uuid.dart';

class EventServiceMock implements EventService {
  late List<Event> _events;
  EventServiceMock() {
    _events = mockedEventList();
  }

  @override
  Future<List<Event>> list(DateTime date) async {
    return _events
        .where((e) => e.startDate?.compareDate(date) ?? false)
        .toList();
  }

  @override
  Future<Event> byId(String id) async {
    return _events.firstWhere((e) => e.id == id);
  }

  @override
  Future<Event> create(Event event) async {
    final newEvent = event.copyWith(
      id: const Uuid().v4(),
      status: EventStatus.todo,
    );
    _events = [..._events, newEvent];
    return newEvent;
  }

  @override
  Future<Event> update(Event event) async {
    _events = _events.where((e) => e.id != event.id).toList()..add(event);
    return event;
  }

  @override
  Future<void> delete(String id) async {
    _events = _events.where((e) => e.id != id).toList();
  }

  static const _rawEvents = '''[{
    "id": "6c250a66-ad54-4c9d-a089-0df5cd0aa188",
    "userId": "6441bd33-b608-43aa-a3bb-80b941ffdc50",
    "startAt": "2022-07-03 19:10:25",
    "startDate": "2022-08-03",
    "duration": 60,
    "status": "todo",
    "title": "Task",
    "detail": "details2",
    "comment": null
  },
  {
    "id": "5c3c7cf6-c175-42d7-8b07-b5ebb2f8f7f8",
    "userId": "6441bd33-b608-43aa-a3bb-80b941ffdc50",
    "startAt": "2022-07-03 19:10:25",
    "startDate": "2022-08-03",
    "duration": 60,
    "status": "todo",
    "title": "Task",
    "detail": "details2",
    "comment": null
  },
  {
    "id": "19845150-e9b9-41a3-9b85-32caad071af9",
    "userId": "6441bd33-b608-43aa-a3bb-80b941ffdc50",
    "startAt": "2022-07-03 19:10:25",
    "startDate": "2022-08-03",
    "duration": 60,
    "status": "todo",
    "title": "Task",
    "detail": "details2",
    "comment": null
  }]''';

  static List<Event> mockedEventList() {
    final mapList = jsonDecode(_rawEvents) as List;
    final eventList = mapList.map((e) => Event.fromJson(e)).toList();
    eventList.first = eventList.first.copyWith(startDate: DateTime.now());
    return eventList;
  }

  static const eventId1 = '6c250a66-ad54-4c9d-a089-0df5cd0aa188';
  static const eventId2 = '5c3c7cf6-c175-42d7-8b07-b5ebb2f8f7f8';
  static const eventId3 = '19845150-e9b9-41a3-9b85-32caad071af9';

  static Event mockEvent1() {
    return Event.fromJson(jsonDecode(_rawEvents)[0]);
  }
}
