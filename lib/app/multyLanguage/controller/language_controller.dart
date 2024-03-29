import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/language_model.dart';

class LanguageController extends GetxController {
//splash controller
  late LanguageModel _defaultLanguage;
  LanguageModel get defaultLanguage => _defaultLanguage;

  late String languageCode;

  // @override
  // void onInit() {
  //   super.onInit();
  //   languageCode = getDefault();
  // }

  void saveLanguages(String code) {
    var locale = Locale(code.toString());
    Get.updateLocale(locale);
    saveLanguage(code);
    languageCode = code;
    update();
  }

  void saveLanguage(String code) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('language', code);
  }

  getDefault() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('language') ??
        AppConstants.defaultLanguageApp;
  }

  Future<String?> getLanguagesCode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('language') ??
        AppConstants.defaultLanguageApp;
  }
}

class AppConstants {
  static const String appName = 'Move My Goods';
  static const String defaultLanguageApp = 'en';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'हिन्दी',
        countryCode: 'IN',
        languageCode: 'hi'),
    LanguageModel(
        imageUrl: '',
        languageName: 'ಕನ್ನಡ',
        countryCode: 'IN',
        languageCode: 'kn'),
    LanguageModel(
        imageUrl: '',
        languageName: 'தமிழ்',
        countryCode: 'IN',
        languageCode: 'ta'),
  ];
}
