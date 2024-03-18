import 'package:flutter/material.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../utils/app style/colors.dart';
import '../../utils/app style/responsive.dart';
import '../../utils/common widgets/button.dart';
import '../../utils/common widgets/textform.dart';
import '../../utils/helpers.dart';
import '../view model/auth_provider.dart';

class ForgotPasswordEnterScreen extends StatelessWidget {
  const ForgotPasswordEnterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
      children: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 5),
            Text(
              'Enter Your Password ',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.secondPrimary),
            ),
            const SizeBoxH(8),
            Text('Enter your New Passsword here',
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black)),
            SizeBoxH(Responsive.height * 5),
            Consumer<AuthProvider>(builder: (context, value, child) {
              return CommonTextForm(
                onChanged: (p0) {},
                borderColor: AppColors.secondPrimary,
                enabledBorder: AppColors.secondPrimary,
                focusedBorder: AppColors.secondPrimary,
                fillColor: AppColors.bgColor,
                hintText: 'New Password',
                radius: 2,
                controller: value.forgetNewPasswordController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                obscureText: value.forgetNewPassword,
                suffixIcon: GestureDetector(
                  onTap: () => value.forgetNewPasswordFn(),
                  child: Icon(value.forgetNewPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              );
            }),
            SizeBoxH(Responsive.height * 3),
            Consumer<AuthProvider>(builder: (context, value, child) {
              return CommonTextForm(
                onChanged: (p0) {},
                borderColor: AppColors.secondPrimary,
                enabledBorder: AppColors.secondPrimary,
                focusedBorder: AppColors.secondPrimary,
                fillColor: AppColors.bgColor,
                hintText: 'Confirm Password',
                radius: 2,
                controller: value.forgetConfirmPasswordController,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.lock),
                obscureText: value.forgetConfirmPassword,
                suffixIcon: GestureDetector(
                  onTap: () => value.forgetConfirmPasswordFn(),
                  child: Icon(value.forgetConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              );
            }),
            SizeBoxH(Responsive.height * 3),
            ButtonWidgets(
              buttonText: 'Change Password',
              bgColor: AppColors.secondPrimary,
              textColor: Colors.white,
              onPressed: () {
                authProvider.changePasswordFn(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
