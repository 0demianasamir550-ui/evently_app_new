import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode _appTheme = ThemeMode.dark;

  ThemeMode get appTheme => _appTheme;

  AppThemeProvider() {
    loadTheme();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (_appTheme == newTheme) return;

    _appTheme = newTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _appTheme == ThemeMode.dark);
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      _appTheme = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  bool isDarkMode() => _appTheme == ThemeMode.dark;
}