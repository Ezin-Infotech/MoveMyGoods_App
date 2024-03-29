import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../utils/app style/responsive.dart';
import '../../utils/common widgets/dialogs.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
      isBackButton: true,
      children: SizedBox(
        height: Responsive.height * 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: 243,
              // height: 432,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Sign Up'.tr,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: const Color(0xffffffff),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizeBoxH(33),
                  CommonTextForm(
                    onChanged: (p0) {},
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppColors.primary,
                    ),
                    controller: authProvider.signUpPhoneController,
                    fillColor: AppColors.bgColor,
                    hintText: 'Mobile No.'.tr,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizeBoxH(42),
                  // CommonTextForm(
                  //   onChanged: (p0) {},
                  //   prefixIcon: Icon(
                  //     Icons.lock,
                  //     color: AppColors.primary,
                  //   ),
                  //   controller: authProvider.emailController,
                  //   fillColor: AppColors.bgColor,
                  //   hintText: 'Password',
                  //   keyboardType: TextInputType.emailAddress,
                  //   suffixIcon: Icon(
                  //     Icons.remove_red_eye,
                  //     color: AppColors.primary,
                  //   ),
                  // ),
                  // const SizeBoxH(42),
                  CommonTextForm(
                    onChanged: (p0) {},
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: AppColors.primary,
                    ),
                    controller: authProvider.signUpEmailController,
                    fillColor: AppColors.bgColor,
                    hintText: 'Email (Optional)',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizeBoxH(31),
                  Center(
                    child: ButtonWidgets(
                        buttonText: 'Verify'.tr,
                        bgColor: AppColors.kLight,
                        textColor: AppColors.primary,
                        onPressed: () {
                          if (authProvider
                              .signUpPhoneController.text.isNotEmpty) {
                            if (authProvider.isPhoneNumber(
                                authProvider.signUpPhoneController.text)) {
                              if (authProvider
                                  .signUpEmailController.text.isNotEmpty) {
                                if (authProvider.isEmail(
                                    authProvider.signUpEmailController.text)) {
                                  context
                                      .read<AuthProvider>()
                                      .getSignUpOTPFn(context: context);
                                } else {
                                  errorBottomSheetDialogs(
                                    isDismissible: false,
                                    enableDrag: false,
                                    context: context,
                                    title: 'please enter valid  email'.tr,
                                    subtitle: '',
                                  );
                                }
                              } else {
                                context
                                    .read<AuthProvider>()
                                    .getSignUpOTPFn(context: context);
                              }
                            } else {
                              errorBottomSheetDialogs(
                                isDismissible: false,
                                enableDrag: false,
                                context: context,
                                title: 'please enter valid  phone number'.tr,
                                subtitle: '',
                              );
                            }
                          } else {
                            errorBottomSheetDialogs(
                              isDismissible: false,
                              enableDrag: false,
                              context: context,
                              title: 'please enter Phone number'.tr,
                              subtitle: '',
                            );
                          }

                          // context.push(const LoginScreen());
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String? text;
  const LabelText({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'Email',
      style: context.textTheme.bodyMedium!.copyWith(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    );
  }
}
