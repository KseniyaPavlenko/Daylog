import 'package:daylog/common/net/dio_interceptor.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:daylog/services/draft/draft_service_impl.dart';
import 'package:daylog/services/local_storage/local_storage_mock.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Draft Service', () {
    late DraftService draftService;
    late LocalStorageMock localStorage;

    setUp((() {
      final dio = Dio();
      dio.options.baseUrl = 'http://localhost:8080/api/v1';

      localStorage = LocalStorageMock();
      localStorage.setToken('login=ksenia4');

      dio.interceptors.add(DioInterceptor(localStorage));
      // dio.interceptors.add(_TokenAddInterceptor());
      draftService = DraftServiceImpl(
        dio: dio,
      );
    }));

    test('get list check', () async {
      //const date = '2022-08-03';
      final list = await draftService.list();
      expect(list, isNotEmpty);
    });

    test('get list by id check', () async {
      const id = 'a28c35da-5c26-43ad-a287-f1c347945cfd';
      final event = await draftService.byId(id);
      expect(event, isNotNull);
      expect(event.id, id);
    });

    test('create draft check', () async {
      final draft = Draft.fromJson({
        "startDate": "2022-07-03",
        "endDate": "2022-08-03",
        "startAt": "2022-07-03 19:10:25",
        "duration": 60,
        "days": 0,
        "title": "Task",
        "detail": "details"
      });
      final newDraft = await draftService.create(draft);
      expect(newDraft, isNotNull);
      expect(newDraft.id, isNotNull);
      expect(newDraft.startDate, draft.startDate);
    });

    test('update event check', () async {
      final draft = Draft.fromJson({
        "startDate": "2022-07-03",
        "endDate": "2022-08-03",
        "startAt": "2022-07-03 19:10:25",
        "duration": 60,
        "days": 0,
        "title": "Task",
        "detail": "details"
      });
      final newDraft = await draftService.create(draft);
      const updatedTitle = 'updated title';
      const updatedDuration = 30;

      final updatedDraft = await draftService.update(newDraft.copyWith(
        title: updatedTitle,
        duration: updatedDuration,
      ));
      expect(updatedDraft.id, newDraft.id);
      expect(updatedDraft.title, updatedTitle);
      expect(updatedDraft.duration, updatedDuration);
    });

    test('delete draft check', () async {
      final draft = Draft.fromJson({
        "startDate": "2022-07-03",
        "endDate": "2022-08-03",
        "startAt": "2022-07-03 19:10:25",
        "duration": 60,
        "days": 0,
        "title": "Task",
        "detail": "details"
      });
      final newDraft = await draftService.create(draft);
      final id = newDraft.id!;
      await draftService.delete(id);
      expectLater(draftService.delete(id), throwsException);
      expectLater(draftService.byId(id), throwsException);
    });
  });
}
