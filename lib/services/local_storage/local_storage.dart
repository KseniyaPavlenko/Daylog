abstract class LocalStorage {
  Future<String?> getToken();
  Future<void> setToken(String? value);
}

class LocalStorageMock implements LocalStorage {
  @override
  void noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
