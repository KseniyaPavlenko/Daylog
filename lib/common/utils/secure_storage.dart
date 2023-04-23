import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';

class DaylogSecureStorage {
  factory DaylogSecureStorage() => _instance;
  DaylogSecureStorage._();
  static final DaylogSecureStorage _instance = DaylogSecureStorage._();

// Create storage
  static const _storage = FlutterSecureStorage();
  static const _pinCodeKey = 'pinCodeKey';
  static const _saltKey = 'saltKey';

  static Future<String?> getPinCodeHash() {
    return _storage.read(key: _pinCodeKey);
  }

  static Future<void> setPinCode(String password) async {
    final salt = _generateSalt();
    await _storage.write(key: _saltKey, value: salt);
    final hash = _hashPassword(password, salt);
    await _storage.write(key: _pinCodeKey, value: hash);
  }

  static Future<String?> encodePincode(String password) async {
    final salt = await _storage.read(key: _saltKey);
    if (salt == null) {
      return null;
    }
    return _hashPassword(password, salt);
  }

  static String _generateSalt([int length = 32]) {
    final rand = Random.secure();
    final saltBytes = List<int>.generate(length, (_) => rand.nextInt(256));
    return base64.encode(saltBytes);
  }

  static String _hashPassword(String password, String salt) {
    const codec =  Utf8Codec();
    final key = codec.encode(password);
    final saltBytes = codec.encode(salt);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(saltBytes);
    return digest.toString();
  }

  static Future<void> deleteStorage() {
    return _storage.deleteAll();
  }
}
