import 'package:flutter/material.dart';

import 'package:mmg/app/bookings/view/widgets/drop_down_widgets.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/custom_text.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    return CommonScaffold(
        children: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingTextFieldWidgets(
          labeText: 'First Name*',
          hintText: 'jhon',
          controller: profileProvider.firstNameController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Last Name**',
          hintText: 'joseph',
          controller: profileProvider.lastNameController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Mobile Number',
          hintText: '+919744213176',
          controller: profileProvider.mobileNumberController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const MyToggleIconButton(),
                Text(
                  'Male',
                  style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xffA8A4B0)),
                )
              ],
            ),
            const SizeBoxV(65),
            Row(
              children: [
                const MyToggleIconButton(),
                Text(
                  'Female',
                  style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xffA8A4B0)),
                ),
              ],
            )
          ],
        ),
        BookingTextFieldWidgets(
          labeText: 'Address Line 1',
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
        const SizeBoxH(10),
        const CustomText(
          text: 'Goods Weight *',
        ),
        const SizeBoxH(8),
        const DropdownInsideTextFormField(),
        const SizeBoxH(8),
        BookingTextFieldWidgets(
          labeText: 'Pincode',
          hintText: '0000001',
          controller: profileProvider.mobileNumberController,
        ),
        BookingTextFieldWidgets(
          labeText: 'Alternate Number',
          hintText: '+919744213176',
          controller: profileProvider.alternativeNumberController,
        ),
      ],
    ));
  }
}
