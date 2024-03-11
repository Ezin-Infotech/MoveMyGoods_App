import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressLineOneController = TextEditingController();
  TextEditingController addressLineTwoController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController selectStateController = TextEditingController();
  TextEditingController picCodeController = TextEditingController();
  TextEditingController alternativeNumberController = TextEditingController();

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
