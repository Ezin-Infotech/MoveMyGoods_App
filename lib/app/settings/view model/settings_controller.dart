import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  int loadingPercentage = 0;

  void init(WebViewController webViewController, String url) {
    webViewController
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          loadingPercentage = 0;

          notifyListeners();
        },
        onProgress: (progress) {
          loadingPercentage = progress;
          notifyListeners();
        },
        onPageFinished: (url) {
          loadingPercentage = 100;
          notifyListeners();
        },
      ))
      ..loadRequest(
        Uri.parse(url),
      );
  }
}
