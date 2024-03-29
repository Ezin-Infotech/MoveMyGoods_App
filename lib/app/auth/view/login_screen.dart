import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/auth/view/sign_up.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../utils/common widgets/dialogs.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            const SizeBoxH(10),
            Container(
              // width: 243,
              // height: 432,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Welcome Back'.tr,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: const Color(0xffffffff),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizeBoxH(20),
                    LabelText(
                      text: 'Email / Phone'.tr,
                    ),
                    const SizeBoxH(8),
                    CommonTextForm(
                      onChanged: (p0) {},
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                      controller: authProvider.emailController,
                      fillColor: AppColors.bgColor,
                      hintText: 'mmg@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizeBoxH(18),
                    LabelText(
                      text: 'Password'.tr,
                    ),
                    const SizeBoxH(8),
                    Consumer<AuthProvider>(builder: (context, value, child) {
                      return CommonTextForm(
                        onChanged: (p0) {},
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.primary,
                        ),
                        controller: value.passWordController,
                        fillColor: AppColors.bgColor,
                        hintText: 'Enter Your Password'.tr,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: value.loginShowPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            value.loginShowPasswordFn();
                            log('abcd');
                          },
                          child: Icon(
                            value.loginShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    }),
                    const SizeBoxH(28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: true,
                        //       activeColor: AppColors.primary,
                        //       side: const BorderSide(
                        //           color: Colors.white, width: 2, strokeAlign: 2),
                        //       onChanged: (value) {},
                        //     ),
                        //     Text(
                        //       'Remember Me',
                        //       style: context.textTheme.bodyMedium!.copyWith(
                        //         color: const Color(0xffffffff),
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        InkWell(
                          onTap: () =>
                              Get.toNamed(AppRoutes.forgetPasswordPage),
                          child: Text(
                            '${'Forgot Password'.tr}?',
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: const Color(0xffffffff),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizeBoxH(31),
                    Center(
                      child: ButtonWidgets(
                          buttonText: 'Login'.tr,
                          bgColor: AppColors.kLight,
                          textColor: AppColors.primary,
                          onPressed: () {
                            if (authProvider.emailController.text.isNotEmpty &&
                                authProvider
                                    .passWordController.text.isNotEmpty) {
                              authProvider.onboardSignInFn(context: context);
                              // if (authProvider
                              //     .isEmail(authProvider.emailController.text)) {
                              //   authProvider.onboardSignInFn(context: context);
                              // } else if (authProvider.isPhoneNumber(
                              //     authProvider.passWordController.text)) {

                              // } else {
                              //   errorBottomSheetDialogs(
                              //     isDismissible: false,
                              //     enableDrag: false,
                              //     context: context,
                              //     title:
                              //         'please enter valid  email or phonenumber',
                              //     subtitle: '',
                              //   );
                              // }
                            } else {
                              errorBottomSheetDialogs(
                                  isDismissible: false,
                                  enableDrag: false,
                                  context: context,
                                  title: 'please enter email and password'.tr,
                                  subtitle: '');
                            }

                            // context.push(const LoginScreen());
                          }),
                    ),
                    const SizeBoxH(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account ?'.tr,
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: const Color(0xffffffff),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up'.tr,
                            style: context.textTheme.bodyLarge!.copyWith(
                              color: const Color(0xffffffff),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
      text ?? 'Email'.tr,
      style: context.textTheme.bodyMedium!.copyWith(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    );
  }
}
