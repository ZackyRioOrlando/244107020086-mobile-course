import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStore {
  TokenStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _accessKey = 'access_token';

  // Simpan token Sanctum
  Future<void> save({required String access}) async {
    await _storage.write(
      key: _accessKey,
      value: access,
    );
  }

  // Ambil token
  Future<String?> readAccess() {
    return _storage.read(key: _accessKey);
  }

  // Hapus token
  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
  }
}