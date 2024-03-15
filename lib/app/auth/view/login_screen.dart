import 'dart:developer';

import 'package:flutter/material.dart';
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Welcome Back ',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: const Color(0xffffffff),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizeBoxH(20),
                  const LabelText(
                    text: 'Email / Phone',
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
                  const LabelText(
                    text: 'Password',
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
                      hintText: 'Enter Your Password',
                      keyboardType: TextInputType.emailAddress,
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
                        onTap: () => Get.toNamed(AppRoutes.forgetPasswordPage),
                        child: Text(
                          'Forgot Password?',
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
                        buttonText: 'Login',
                        bgColor: AppColors.kLight,
                        textColor: AppColors.primary,
                        onPressed: () {
                          authProvider.onboardSignInFn(context: context);
                          // context.push(const LoginScreen());
                        }),
                  ),
                  const SizeBoxH(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account ? ',
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
                          'Sign Up',
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
