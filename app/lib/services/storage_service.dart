import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _themeKey = 'app_theme';
  static const String _langKey = 'app_language';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Token
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    await _prefs.remove(_tokenKey);
  }

  // User Data
  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _prefs.setString(_userKey, json.encode(userData));
  }

  Map<String, dynamic>? getUser() {
    final userStr = _prefs.getString(_userKey);
    if (userStr != null) {
      return json.decode(userStr);
    }
    return null;
  }

  Future<void> deleteUser() async {
    await _prefs.remove(_userKey);
  }

  // Theme
  Future<void> saveTheme(String theme) async {
    await _prefs.setString(_themeKey, theme);
  }

  String? getTheme() {
    return _prefs.getString(_themeKey);
  }

  // Language
  Future<void> saveLanguage(String language) async {
    await _prefs.setString(_langKey, language);
  }

  String? getLanguage() {
    return _prefs.getString(_langKey);
  }

  // Clear All
  Future<void> clearAll() async {
    await Future.wait([
      deleteToken(),
      deleteUser(),
      _prefs.remove(_themeKey),
      _prefs.remove(_langKey),
    ]);
  }
}
