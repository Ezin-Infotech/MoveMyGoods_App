// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  ThemeProvider(bool isDark) {
    if (isDark) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  void toggleTheme(bool isOn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isOn == true) {
      themeMode = ThemeMode.dark;
      sharedPreferences.setBool('is_dark', true);
      notifyListeners();
    } else {
      themeMode = ThemeMode.light;
      sharedPreferences.setBool('is_dark', false);
      notifyListeners();
    }
    notifyListeners();
  }
}
