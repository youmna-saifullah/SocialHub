import 'package:flutter/material.dart';

import '../../../../core/services/local_storage/local_storage_service.dart';

/// Provider for app settings (theme, notifications, etc.)
class SettingsProvider extends ChangeNotifier {
  final LocalStorageService _localStorage;

  SettingsProvider({required LocalStorageService localStorage})
      : _localStorage = localStorage {
    _loadSettings();
  }

  // State
  ThemeMode _themeMode = ThemeMode.system;
  bool _notificationsEnabled = true;

  // Getters
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get notificationsEnabled => _notificationsEnabled;

  void _loadSettings() {
    final savedTheme = _localStorage.getThemeMode();
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.name == savedTheme,
        orElse: () => ThemeMode.system,
      );
    }
    
    _notificationsEnabled = _localStorage.getBool('notifications_enabled') ?? true;
  }

  /// Toggle dark mode
  Future<void> toggleDarkMode() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _localStorage.setThemeMode(_themeMode.name);
    notifyListeners();
  }

  /// Set specific theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _localStorage.setThemeMode(mode.name);
    notifyListeners();
  }

  /// Toggle notifications
  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    await _localStorage.setBool('notifications_enabled', _notificationsEnabled);
    notifyListeners();
  }

  /// Clear app cache
  Future<void> clearCache() async {
    // In a real app, you would clear image cache, cached data, etc.
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
