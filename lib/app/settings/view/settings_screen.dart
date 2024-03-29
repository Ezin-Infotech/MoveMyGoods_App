import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/settings/view%20model/theme_notifier.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../home/view model/home_provider.dart';
import '../../utils/app style/responsive.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<String> settingsText = [
    'Profile'.tr,
    'Dark Mode'.tr,
    'Terms & Conditions'.tr,
    'Privacy Policy'.tr,
    'Contact Us'.tr,
    'Version'.tr,
    'Logout'.tr,
  ];
  List<String> userNotLoggedList = [
    'Dark Mode'.tr,
    'Terms & Conditions'.tr,
    'Privacy Policy'.tr,
    'Contact Us'.tr,
    'Version'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return CommonScaffold(
      isBackButton: false,
      isSettings: true,
      padding: 0,
      children: Consumer<SettingsProvider>(builder: (context, value, _) {
        return Consumer<AuthProvider>(builder: (context, obj, _) {
          return Column(
            children: [
              !obj.isUserLogged
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Showcase(
                              key: homeProvider.globalKey10,
                              description: 'You had account please login',
                              child: InkWell(
                                onTap: () => Get.toNamed(AppRoutes.login),
                                child: Container(
                                  height: Responsive.height * 5,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondPrimary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Login'.tr,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizeBoxV(16),
                          Expanded(
                            child: Showcase(
                              key: homeProvider.globalKey11,
                              description:
                                  'You have not account please Sign up',
                              child: InkWell(
                                onTap: () => Get.toNamed(AppRoutes.signUp),
                                child: Container(
                                  height: Responsive.height * 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary),
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Text(
                                      'Sign Up'.tr,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: obj.userProfilePic == null ||
                              obj.userProfilePic!.isEmpty
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                obj.getUserProfilePicStatus ==
                                        GetUserProfilePicStatus.loading
                                    ? const CircularProgressIndicator()
                                    : obj.userProfilePic == null
                                        ? const SizedBox.shrink()
                                        : CircleAvatar(
                                            maxRadius: 20,
                                            backgroundImage: NetworkImage(
                                                "https://storage.googleapis.com/common-mmg/${obj.userProfilePic![0].path}"),
                                          ),
                                SizeBoxV(Responsive.width * 2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${obj.profileDataModel.data!.firstName ?? ''}  ${obj.profileDataModel.data!.lastName ?? ''}",
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizeBoxH(Responsive.height * 0.1),
                                    Text(
                                      obj.profileDataModel.data!.mobileNumber ??
                                          '',
                                      style:
                                          context.textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                    ),
              obj.isUserLogged ? const Divider() : const SizedBox.shrink(),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: obj.isUserLogged
                          ? () => context
                              .read<SettingsProvider>()
                              .userLoggedFn(index: index, context: context)
                          : () => context
                              .read<SettingsProvider>()
                              .userNotLoggedFn(index: index, context: context),
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: Icon(obj.isUserLogged
                            ? value.settingsIcon[index]
                            : value.userNotLoggedIcon[index]),
                        title: Text(obj.isUserLogged
                            ? settingsText[index]
                            : userNotLoggedList[index]),
                        trailing: obj.isUserLogged
                            ? index == 1
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
                                : const SizedBox.shrink()
                            : index == 0
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
                  itemCount: obj.isUserLogged
                      ? value.settingsIcon.length
                      : userNotLoggedList.length)
            ],
          );
        });
      }),
    );
  }
}
