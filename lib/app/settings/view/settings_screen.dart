import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/settings/view%20model/theme_notifier.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../utils/app style/app_images.dart';
import '../../utils/app style/responsive.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      children: Consumer<SettingsProvider>(builder: (context, value, _) {
        return Consumer<AuthProvider>(builder: (context, obj, _) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: Responsive.height * 5,
                      decoration: BoxDecoration(
                        color: AppColors.secondPrimary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  const SizeBoxV(16),
                  Expanded(
                    child: Container(
                      height: Responsive.height * 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primary),
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Signup',
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    width: Responsive.width * 12,
                    height: Responsive.width * 12,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.profileImage),
                        fit: BoxFit.contain,
                      ),
                      shape: const OvalBorder(side: BorderSide.none),
                    ),
                  ),
                  SizeBoxV(Responsive.width * 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'john joseph',
                        style: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      SizeBoxH(Responsive.height * 0.1),
                      Text(
                        '+91 9123456789',
                        style: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
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
                        leading: Icon(obj.isUserLogged
                            ? value.settingsIcon[index]
                            : value.userNotLoggedIcon[index]),
                        title: Text(obj.isUserLogged
                            ? value.settingsText[index]
                            : value.userNotLoggedList[index]),
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
                      : value.userNotLoggedList.length)
            ],
          );
        });
      }),
    );
  }
}
