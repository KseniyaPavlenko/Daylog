import 'dart:convert';

import 'package:daylog/models/draft.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:dio/dio.dart';

class DraftServiceImpl implements DraftService {
  final Dio dio;

  DraftServiceImpl({required this.dio});

  // Paths
  static const _draftsPath = '/drafts';


  @override
  Future<List<Draft>> list() async {
    final response = await dio.get(_draftsPath); //
    final rawList = jsonDecode(response.data) as List<dynamic>;
    final list = rawList.map((e) => Draft.fromJson(e)).toList();
    return list;
  }

  @override
  Future<Draft> byId(String id) async {
    final response = await dio.get('$_draftsPath/$id');
    final draft = Draft.fromJson(jsonDecode(response.data));
    return draft;
  }

  @override
  Future<Draft> create(Draft draft) async {
    final response =
        await dio.post(_draftsPath, data: jsonEncode(draft.toJson()));
    final newDraft = Draft.fromJson(jsonDecode(response.data));
    return newDraft;
  }

  @override
  Future<Draft> update(Draft draft) async {
    final response =
        await dio.put('$_draftsPath/${draft.id}', data: jsonEncode(draft.toJson()));
    final updatedDraft = Draft.fromJson(jsonDecode(response.data));
    return updatedDraft;
  }

  @override
  Future<void> delete(String id) async {
    await dio.delete('$_draftsPath/$id');
  }
}
