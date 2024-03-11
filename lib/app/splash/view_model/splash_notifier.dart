import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/utils/routes/route_names.dart';

class SplashProvider extends ChangeNotifier {
  bool checkingButton = false;
  bool isLoad = false;
  Future<void> changeScreen() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );

    // if (AppPref.isFirst == true) {

    Get.offAllNamed(AppRoutes.loginOrHome);

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
}
