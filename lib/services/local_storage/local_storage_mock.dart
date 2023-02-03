import 'package:daylog/services/local_storage/local_storage.dart';

class LocalStorageMock implements LocalStorage {
  String? _token;
  @override
  Future<String?> getToken() async {
    return _token;
  }

  @override
  Future<void> setToken(String? value) async {
    _token = value;
  }
}
