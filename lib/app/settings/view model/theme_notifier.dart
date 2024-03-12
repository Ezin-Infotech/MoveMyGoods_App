import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      print('dark mode');
      themeMode = ThemeMode.dark;
      sharedPreferences.setBool('is_dark', true);
      notifyListeners();
    } else {
      print('light mode');
      themeMode = ThemeMode.light;
      sharedPreferences.setBool('is_dark', false);
      notifyListeners();
    }
    notifyListeners();
  }
}
