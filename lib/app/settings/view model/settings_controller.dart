import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/settings/view/webview/terms_and_privacy.dart';
import 'package:mmg/app/settings/view/widgets/profile_page.dart';
import 'package:mmg/app/utils/alert_dialog.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  List<String> userNotLoggedList = [
    'Dark Mode',
    'Terms & Conditions',
    'Privacy Policy',
    'Contact Us',
    'Version',
  ];

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
  }

  userLoggedFn({required int index, required BuildContext context}) {
    if (index == 0) {
      context.read<AuthProvider>().setProfileValues(context: context);
      Get.to(const ProfileScreen());
    } else if (index == 2) {
      Get.to(const TermsAndPrivacy(
        url:
            'https://mail.google.com/mail/u/0/#search/zaya+%5C+/FMfcgzGwJvpfWWmqXxshHtJgmlXcfWhN',
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
            title: 'Logout',
            content: 'Are you sure yow want to Logout?',
            buttonLabel: 'Logout',
            onTapYes: () {
              logoutUser(context: context);
              Get.back();
              // value.foodCartProductRemovefn(
              //     productIds:
              //         items.product!.id.toString());
            },
          );
        },
      );
    } else {}
  }

  userNotLoggedFn({required int index, required BuildContext context}) {
    if (index == 1) {
      Get.to(const TermsAndPrivacy(
        url:
            'https://mail.google.com/mail/u/0/#search/zaya+%5C+/FMfcgzGwJvpfWWmqXxshHtJgmlXcfWhN',
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
