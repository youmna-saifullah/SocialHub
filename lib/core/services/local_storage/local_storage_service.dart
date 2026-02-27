import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_config.dart';

/// Service for local storage operations using SharedPreferences
class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService({required SharedPreferences prefs}) : _prefs = prefs;

  // Theme Mode
  Future<bool> setThemeMode(String mode) async {
    return _prefs.setString(AppConfig.themeKey, mode);
  }

  String? getThemeMode() {
    return _prefs.getString(AppConfig.themeKey);
  }

  // Onboarding
  Future<bool> setOnboardingCompleted(bool completed) async {
    return _prefs.setBool(AppConfig.onboardingKey, completed);
  }

  bool getOnboardingCompleted() {
    return _prefs.getBool(AppConfig.onboardingKey) ?? false;
  }

  // Auth Token
  Future<bool> setAuthToken(String token) async {
    return _prefs.setString(AppConfig.tokenKey, token);
  }

  String? getAuthToken() {
    return _prefs.getString(AppConfig.tokenKey);
  }

  Future<bool> clearAuthToken() async {
    return _prefs.remove(AppConfig.tokenKey);
  }

  // User Data
  Future<bool> setUserData(String userData) async {
    return _prefs.setString(AppConfig.userKey, userData);
  }

  String? getUserData() {
    return _prefs.getString(AppConfig.userKey);
  }

  Future<bool> clearUserData() async {
    return _prefs.remove(AppConfig.userKey);
  }

  // Generic methods
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  Future<bool> clear() async {
    return _prefs.clear();
  }

  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
