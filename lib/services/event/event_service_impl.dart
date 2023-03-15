import 'dart:convert';

import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:dio/dio.dart';

class EventServiceImpl implements EventService {
  final Dio dio;

  EventServiceImpl({required this.dio});

  // Paths
  static const _eventsPath = '/events';

  @override
  Future<List<Event>> list(DateTime date) async {
    final response = await dio
        .get(_eventsPath, queryParameters: {'date': date.formatDate()}); //
    final rawList = jsonDecode(response.data) as List<dynamic>;
    final list = rawList.map((e) => Event.fromJson(e)).toList();
    return list;
  }

  @override
  Future<Event> byId(String id) async {
    final response = await dio.get('$_eventsPath/$id');
    final event = Event.fromJson(jsonDecode(response.data));
    return event;
  }

  @override
  Future<Event> create(Event event) async {
    final response =
        await dio.post(_eventsPath, data: jsonEncode(event.toJson()));
    final newEvent = Event.fromJson(jsonDecode(response.data));
    return newEvent;
  }

  @override
  Future<Event> update(Event event) async {
    final response =
        await dio.put('$_eventsPath/${event.id}', data: jsonEncode(event.toJson()));
    final updatedEvent = Event.fromJson(jsonDecode(response.data));
    return updatedEvent;
  }

  @override
  Future<void> delete(String id) async {
    await dio.delete('$_eventsPath/$id');
  }
}
