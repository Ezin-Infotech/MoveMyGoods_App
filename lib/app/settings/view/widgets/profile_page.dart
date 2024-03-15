import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/bookings/view/widgets/drop_down_widgets.dart';
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
    final profileProvider = Provider.of<AuthProvider>(context, listen: false);
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
          readOnly: true,
          labeText: 'Mobile Number',
          hintText: '+919744213176',
          controller: profileProvider.mobileNumberController,
        ),
        Consumer<AuthProvider>(builder: (context, obj, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  MyToggleIconButton(
                    isToggled: obj.genderId == 1,
                    onPressed: () {
                      context.read<AuthProvider>().setGenderId(value: 1);
                    },
                  ),
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
                  MyToggleIconButton(
                    isToggled: obj.genderId == 2,
                    onPressed: () {
                      context.read<AuthProvider>().setGenderId(value: 2);
                    },
                  ),
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
          );
        }),
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
          text: 'Select State *',
        ),
        const SizeBoxH(8),
        const DropdownInsideTextFormField(),
        const SizeBoxH(8),
        const CustomText(
          text: 'Select City *',
        ),
        const SizeBoxH(8),
        const DropdownInsideTextFormField(),
        const SizeBoxH(8),
        BookingTextFieldWidgets(
          keyboardType: TextInputType.number,
          labeText: 'Pincode',
          hintText: '0000001',
          controller: profileProvider.picCodeController,
        ),
        BookingTextFieldWidgets(
          keyboardType: TextInputType.phone,
          labeText: 'Alternate Number',
          hintText: '+919744213176',
          controller: profileProvider.alternativeNumberController,
        ),
      ],
    ));
  }
}
