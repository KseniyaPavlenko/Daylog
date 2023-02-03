import 'package:daylog/common/utils/logger.dart';
import 'package:daylog/services/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageImlp extends LocalStorage {
  @override
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenPref);
      return token;
    } catch (e) {
      log.e(e);
    }
    return null;
  }

  @override
  Future<void> setToken(String? value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (value == null) {
        prefs.remove(_tokenPref);
      } else {
        prefs.setString(_tokenPref, value);
      }
    } catch (e) {
      log.e(e);
    }
  }

  static const _tokenPref = 'TOKEN_PREF';
}
