import 'dart:convert';

import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:dio/dio.dart';

class EventServiceImpl implements EventService {
  final Dio dio;

  EventServiceImpl({required this.dio});

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<List<Event>> list(DateTime date) async {
    final response = await dio
        .get('/events', queryParameters: {'date': date.formatDate()}); //
    final rawList = jsonDecode(response.data) as List<dynamic>;
    final list = rawList.map((e) => Event.fromJson(e)).toList();
    return list;
  }

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<Event> byId(String id) async {
    final response = await dio.get('/events/$id');
    final event = Event.fromJson(jsonDecode(response.data));
    return event;
  }

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<Event> create(Event event) async {
    final response =
        await dio.post('/events', data: jsonEncode(event.toJson()));
    final newEvent = Event.fromJson(jsonDecode(response.data));
    return newEvent;
  }

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<Event> update(Event event) async {
    final response =
        await dio.put('/events/${event.id}', data: jsonEncode(event.toJson()));
    final updatedEvent = Event.fromJson(jsonDecode(response.data));
    return updatedEvent;
  }

  // TODO(Kseniya): отформатировать как AuthServiceImpl.login
  @override
  Future<void> delete(String id) async {
    await dio.delete('/events/$id');
  }
}
