// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/settings/view/webview/terms_and_privacy.dart';
import 'package:mmg/app/settings/view/widgets/profile_page.dart';
import 'package:mmg/app/utils/alert_dialog.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsProvider with ChangeNotifier {
  List<IconData> userNotLoggedIcon = [
    Icons.dark_mode,
    Icons.file_copy_rounded,
    Icons.lock,
    Icons.phone,
    Icons.android,
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
  TextEditingController dateController = TextEditingController();

  ValueNotifier<File> emptyFile = ValueNotifier<File>(File(''));

  ValueNotifier<File?> userPhotoFile = ValueNotifier<File?>(null);

  String passporthintText = '';
  String userPhotohintText = '';

  Future pickImageFromGalleryOrCamera(
      bool isGallery, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
          source: isGallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      final File imageTemporary = File(image.path);

      userPhotoFile.value = imageTemporary;
      // List<String> parts = imageTemporary.path.split('/');
      // String fileName = parts.last;
      // userPhotohintText = fileName;
      String imagePath = imageTemporary.path;
      String newPath = imagePath.replaceAll(".jpg", ".jpeg");

      // Rename the file
      File newFile = await File(imagePath).copy(newPath);
      List<String> parts = newFile.path.split('/');
      String fileName = parts.last;
      userPhotohintText = fileName;
      // Read the image file as bytes
      // List<int> imageBytes = await newFile.readAsBytes();

// Encode the bytes into base64
      // String base64Image = base64Encode(imageBytes);
      log("base64Image: ${newFile.path.toString()}");
      context
          .read<AuthProvider>()
          .uploadImageFn(context: context, file: newFile, fileName: fileName);
      log("imageBytes: ${fileName.toString()}");

      notifyListeners();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

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

  logoutUser({required BuildContext context}) {
    AppPref.userToken = '';
    AppPref.userProfileId = '';
    context.read<AuthProvider>().isUserLoggedFn(isLogged: false);
    context.read<BookingProvider>().clearBookingList();
  }

  userLoggedFn({required int index, required BuildContext context}) {
    if (index == 0) {
      context.read<AuthProvider>().setProfileValues(context: context);
      Get.to(const ProfileScreen());
    } else if (index == 2) {
      Get.to(const TermsAndPrivacy(
        url: 'http://movemygoods.in/termsandconditions',
      ));
    } else if (index == 3) {
      Get.to(const TermsAndPrivacy(
        url: 'http://movemygoods.in/policy',
      ));
    } else if (index == 4) {
      launch("tel:9019029036");
    } else if (index == 6) {
      showDialog(
        context: context,
        builder: (context) {
          return DeleteAlertDialog(
            // isDarkMode: value.isDarkMode,
            title: 'Logout'.tr,
            content: 'Are you sure you want to Logout?'.tr,
            buttonLabel: 'Logout'.tr,
            onTapYes: () {
              logoutUser(context: context);
              Get.back();
            },
          );
        },
      );
    } else {}
  }

  userNotLoggedFn({required int index, required BuildContext context}) {
    if (index == 1) {
      Get.to(const TermsAndPrivacy(
        url: 'http://movemygoods.in/termsandconditions',
      ));
    } else if (index == 2) {
      Get.to(const TermsAndPrivacy(
        url: 'http://movemygoods.in/policy',
      ));
    } else if (index == 3) {
      launch("tel:9019029036");
    }
  }
}
