import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

/// Wraps secure storage (tokens) and shared prefs (non-sensitive flags).
class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;
  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  // --- Tokens (secure) ---
  Future<void> saveAccessToken(String token) =>
      _secure.write(key: AppConstants.keyAccessToken, value: token);

  Future<String?> getAccessToken() =>
      _secure.read(key: AppConstants.keyAccessToken);

  Future<void> saveRefreshToken(String token) =>
      _secure.write(key: AppConstants.keyRefreshToken, value: token);

  Future<String?> getRefreshToken() =>
      _secure.read(key: AppConstants.keyRefreshToken);

  Future<void> clearTokens() async {
    await _secure.delete(key: AppConstants.keyAccessToken);
    await _secure.delete(key: AppConstants.keyRefreshToken);
  }

  // --- Non-sensitive flags (shared prefs) ---
  bool get onboardingSeen =>
      _prefs.getBool(AppConstants.keyOnboardingSeen) ?? false;

  Future<void> setOnboardingSeen(bool value) =>
      _prefs.setBool(AppConstants.keyOnboardingSeen, value);

  String? get userId => _prefs.getString(AppConstants.keyUserId);

  Future<void> setUserId(String id) =>
      _prefs.setString(AppConstants.keyUserId, id);

  Future<void> clearAll() async {
    await clearTokens();
    await _prefs.clear();
  }
}
