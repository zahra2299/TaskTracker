import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String local = "en";
  ThemeMode theme = ThemeMode.light;

  changeLanguage(String langCode) {
    local = langCode;
    notifyListeners();
  }

  changeTheme(ThemeMode mode) {
    theme = mode;
    notifyListeners();
  }
}
