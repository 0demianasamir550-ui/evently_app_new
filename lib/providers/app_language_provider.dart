import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  String _appLanguage = 'en';

  String get appLanguage => _appLanguage;

  AppLanguageProvider() {
    _loadLanguage();
  }

  void changeLanguage(String lang) {
    _appLanguage = lang;
    _saveLanguage();
    notifyListeners();
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _appLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  void _saveLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', _appLanguage);
  }
}