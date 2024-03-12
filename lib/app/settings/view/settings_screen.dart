import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/settings/view%20model/theme_notifier.dart';
import 'package:mmg/app/settings/view/webview/terms_and_privacy.dart';
import 'package:mmg/app/settings/view/widgets/profile_page.dart';
import 'package:mmg/app/utils/alert_dialog.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      children: Consumer<SettingsProvider>(builder: (context, value, _) {
        return Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
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
                              titile: 'Logout',
                              content: 'Are you sure yow want to Logout?',
                              buttonLabel: 'Logout',
                              onTapYes: () {
                                // value.foodCartProductRemovefn(
                                //     productIds:
                                //         items.product!.id.toString());
                              },
                            );
                          },
                        );
                      } else {}
                    },
                    child: ListTile(
                      leading: Icon(value.settingsIcon[index]),
                      title: Text(value.settingsText[index]),
                      trailing: index == 1
                          ? Consumer<ThemeNotifier>(
                              builder: (context, valueP, child) => Switch(
                                activeColor: AppColors.primary,
                                activeTrackColor: AppColors.primaryBorder,
                                inactiveThumbColor: AppColors.primary,
                                value: valueP.isDarkMode,
                                onChanged: (value) {
                                  valueP.toggleTheme(value);
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizeBoxH(10),
                itemCount: value.settingsIcon.length)
          ],
        );
      }),
    );
  }
}
