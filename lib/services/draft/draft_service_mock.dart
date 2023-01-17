import 'dart:convert';

import 'package:daylog/models/draft.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:uuid/uuid.dart';

class DraftServiceMock implements DraftService {
  late List<Draft> _drafts;

  DraftServiceMock() {
    _drafts = mockedDraftList();
  }

  @override
  Future<List<Draft>> list() async {
    return _drafts;
  }

  @override
  Future<Draft> byId(String id) async {
    return _drafts.firstWhere((e) => e.id == id);
  }

  @override
  Future<Draft> create(Draft draft) async {
    final newDraft = draft.copyWith(
      id: const Uuid().v4(),
    );
    _drafts = [..._drafts, newDraft];

    return newDraft;
  }

  @override
  Future<Draft> update(Draft draft) async {
    _drafts = _drafts.where((e) => e.id != draft.id).toList()..add(draft);
    return draft;
  }

  @override
  Future<void> delete(String id) async {
    _drafts = _drafts.where((e) => e.id != id).toList();
  }

  static const _rawDrafts = '''[{
    "id": "19dea3dd-eba9-473d-95ff-80e6ee00a710",
    "userId": "6441bd33-b608-43aa-a3bb-80b941ffdc50",
    "startDate": "2022-07-03",
    "endDate": "2022-08-03",
    "startAt": "2022-07-03 19:10:25",
    "duration": 60,
    "days": 0,
    "title": "Task",
    "detail": "details"
  },
  {
    "id": "5a1101fa-8361-40ed-9a6b-b9eda6b1595b",
    "userId": "6441bd33-b608-43aa-a3bb-80b941ffdc50",
    "startDate": "2022-07-03",
    "endDate": "2022-08-03",
    "startAt": "2022-07-03 19:10:25",
    "duration": 60,
    "days": 0,
    "title": "Task",
    "detail": "details"
  }]''';

  static List<Draft> mockedDraftList() {
    final list = jsonDecode(_rawDrafts) as List;
    return list.map((e) => Draft.fromJson(e)).toList();
  }

  static const draftId1 = '19dea3dd-eba9-473d-95ff-80e6ee00a710';
  static const draftId2 = '5a1101fa-8361-40ed-9a6b-b9eda6b1595b';
  static Draft mockDraft1() {
    return Draft.fromJson(jsonDecode(_rawDrafts)[0]);
  }
}
