import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';

import 'package:mmg/app/bookings/view/widgets/drop_down_widgets.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/custom_text.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class SignUpProfileScreen extends StatelessWidget {
  const SignUpProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
        children: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingTextFieldWidgets(
          labeText: 'First Name *',
          hintText: 'jhon',
          controller: profileProvider.firstNameController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Last Name',
          hintText: 'joseph',
          controller: profileProvider.lastNameController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Mobile Number *',
          hintText: '+919744213176',
          controller: authProvider.signUpPhoneController,
        ),
        const SizeBoxH(18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const MyToggleIconButtonFilter(
                  isToggled: true,
                ),
                const SizeBoxV(8),
                Text(
                  'Male',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            const SizeBoxV(65),
            Row(
              children: [
                const MyToggleIconButtonFilter(
                  isToggled: false,
                ),
                const SizeBoxV(8),
                Text(
                  'Female',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
        BookingTextFieldWidgets(
          labeText: 'Date of Birth *',
          hintText: '+919744213176',
          controller: authProvider.signUpPhoneController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Address Line 1 *',
          hintText: 'Mysore Road',
          controller: profileProvider.addressLineOneController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Address Line 2',
          hintText: 'Near Canara Bank',
          controller: profileProvider.addressLineTwoController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Landmark',
          hintText: 'Near canara bank',
          controller: profileProvider.landMarkController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Select Country *',
          hintText: 'Near canara bank',
          controller: profileProvider.landMarkController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Select State *',
          hintText: 'Near canara bank',
          controller: profileProvider.landMarkController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Select City *',
          hintText: 'Near canara bank',
          controller: profileProvider.landMarkController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Alternate Number',
          hintText: '+919744213176',
          controller: profileProvider.alternativeNumberController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Password *',
          hintText: 'Password',
          controller: profileProvider.alternativeNumberController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Confirm Password *',
          hintText: 'Confirm Password',
          controller: profileProvider.alternativeNumberController,
        ),
        const SizeBoxH(20),
        Center(
          child: ButtonWidgets(
            buttonText: 'Submit',
            onPressed: () {},
          ),
        )
      ],
    ));
  }
}
