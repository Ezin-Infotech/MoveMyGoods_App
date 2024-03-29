// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/multyLanguage/controller/language_controller.dart';
// import 'package:location/location.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {
  bool checkingButton = false;
  bool isLoad = false;
  Future<void> changeScreen({required BuildContext context}) async {
    checkLanguage();
    await Future.delayed(
      const Duration(seconds: 8),
    );

    // if (AppPref.isFirst == true) {
    context.read<AuthProvider>().checkIsUserLoggedOnCacheFn();
    Get.offAllNamed(AppRoutes.loginOrHome);
    // Location location = Location();
    // bool serviceEnabled;
    // PermissionStatus permissionGranted;
    // LocationData locationData;
    // serviceEnabled = await location.serviceEnabled();
    // if (!serviceEnabled) {
    //   serviceEnabled = await location.requestService();
    //   if (!serviceEnabled) {
    //     return;
    //   }
    // }

    // } else {
    //   Get.offAllNamed(AppRoutes.getStarted);
    // }
  }

  Future<bool> checking() async {
    checkingButton = true;

    notifyListeners();
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        notifyListeners();
        return true;
      }
      return false;
    } on SocketException catch (_) {
      notifyListeners();
      return false;
    }
  }

  void checkLanguage() async {
    LanguageController languageController = Get.put(LanguageController());
    if (await languageController.getLanguagesCode() != '') {
      var locale = await languageController.getLanguagesCode();
      Get.updateLocale(Locale(locale!));
    } else {
      var locale = languageController.defaultLanguage.languageCode != '' &&
              languageController.defaultLanguage.languageCode != ''
          ? Locale(languageController.defaultLanguage.languageCode.toString())
          : const Locale('en');
      Get.updateLocale(locale);
    }
  }
}
