import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../utils/common widgets/button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
      isBackButton: true,
      children: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizeBoxH(Responsive.height * 5),
            Text(
              '${'Forgot Password'.tr}?',
              style: context.textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.secondPrimary),
            ),
            const SizeBoxH(8),
            Text('${"Enter Mobile Number and get OTP".tr} to ${"verify".tr}',
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black)),
            SizeBoxH(Responsive.height * 5),
            CommonTextForm(
              onChanged: (p0) {},
              borderColor: AppColors.secondPrimary,
              enabledBorder: AppColors.secondPrimary,
              focusedBorder: AppColors.secondPrimary,
              fillColor: AppColors.bgColor,
              hintText: 'Phone number'.tr,
              radius: 2,
              controller: authProvider.signUpPhoneController,
              keyboardType: TextInputType.number,
            ),
            SizeBoxH(Responsive.height * 3),
            ButtonWidgets(
              buttonText: 'Send OTP'.tr,
              bgColor: AppColors.secondPrimary,
              textColor: Colors.white,
              onPressed: () {
                authProvider.sendOtpToPhoneOnForgotPasswordFn(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
