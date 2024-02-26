import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  List<String> settingsText = [
    'Profile',
    'Dark Mode',
    'Terms & Conditions',
    'Privacy Policy',
    'Contact Us',
    'Version',
    'Logout'
  ];
  List<IconData> settingsIcon = [
    Icons.person,
    Icons.dark_mode,
    Icons.file_copy_rounded,
    Icons.lock,
    Icons.phone,
    Icons.android,
    Icons.logout
  ];
}
