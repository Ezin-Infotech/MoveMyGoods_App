import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/bookings/view/widgets/drop_down_widgets.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/custom_text.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../../utils/app style/colors.dart';
import '../../../utils/common widgets/textform.dart';
import '../../view model/settings_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        const SizeBoxH(18),
        const CustomText(
          text: 'Date Of Bith',
        ),
        const SizeBoxH(8),
        Consumer<SettingsProvider>(builder: (context, value, child) {
          return CommonTextForm(
            readOnly: true,
            controller: value.dateController,
            onChanged: (p0) {},
            radius: 4.0,
            fillColor: Colors.transparent,
            enabledBorder: const Color(0xffDBDBDB),
            borderColor: const Color(0xffDBDBDB),
            focusedBorder: const Color(0xffDBDBDB),
            hintText: 'MM/DD/YY',
            hintTextStyle: context.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w300, color: const Color(0xff222222)),
            hintTextColor: AppColors.darkGrey,
            suffixIcon: const Icon(Icons.calendar_month),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                // initialDate: DateTime.now(),
                firstDate: DateTime(1940),
                lastDate: DateTime(2006),
              );
              if (pickedDate != null) {
                int timestamp = pickedDate.millisecondsSinceEpoch;
                String formattedDate =
                    DateFormat("yyyy-MM-dd").format(pickedDate);

                setState(() {
                  value.dateController.text = formattedDate.toString();
                });
              } else {}
            },
          );
        }),
        const SizeBoxH(18),
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
