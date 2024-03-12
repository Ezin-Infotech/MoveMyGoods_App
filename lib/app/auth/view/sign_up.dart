import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/auth/view/login_screen.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
      children: Column(
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
                    'Sign up',
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
                    Icons.person,
                    color: AppColors.primary,
                  ),
                  controller: authProvider.emailController,
                  fillColor: AppColors.bgColor,
                  hintText: 'Mobile No',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizeBoxH(42),
                CommonTextForm(
                  onChanged: (p0) {},
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.primary,
                  ),
                  controller: authProvider.emailController,
                  fillColor: AppColors.bgColor,
                  hintText: 'Password',
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: AppColors.primary,
                  ),
                ),
                const SizeBoxH(42),
                CommonTextForm(
                  onChanged: (p0) {},
                  prefixIcon: Icon(
                    Icons.lock,
                    color: AppColors.primary,
                  ),
                  controller: authProvider.emailController,
                  fillColor: AppColors.bgColor,
                  hintText: 'Confirm Password',
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: AppColors.primary,
                  ),
                ),
                const SizeBoxH(31),
                Center(
                  child: ButtonWidgets(
                      buttonText: 'Sign up',
                      bgColor: AppColors.kLight,
                      textColor: AppColors.primary,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                        // context.push(const LoginScreen());
                      }),
                ),
              ],
            ),
          ),
        ],
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