import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/custom_text.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../../utils/app style/colors.dart';
import '../../../utils/common widgets/textform.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Consumer<AuthProvider>(builder: (context, profileProvider, _) {
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
            suffixIcon: Icon(
              Icons.edit_outlined,
              color: AppColors.primary,
            ),
            controller: profileProvider.mobileNumberController,
          ),
          const SizeBoxH(18),
          const CustomText(
            text: 'Date Of Birth',
          ),
          const SizeBoxH(8),
          CommonTextForm(
            readOnly: true,
            controller: profileProvider.dateController,
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
            suffixIcon: Icon(
              Icons.calendar_month,
              color: AppColors.primary,
            ),
            onTap: () async {
              authProvider.convertToTimeStampFn(context: context);
            },
          ),
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
          SizedBox(
            height: Responsive.height * 6,
            child: DropDownSearchField(
              hideKeyboard: true,
              hideOnEmpty: true,
              textFieldConfiguration: TextFieldConfiguration(
                controller: profileProvider.stateController,
                autofocus: false,
                style: context.textTheme.bodyLarge!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return profileProvider.stateListElement.where((items) {
                  return items.name.toString().toLowerCase().contains(
                        pattern.toLowerCase(),
                      );
                }).toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion.name.toString()));
              },
              onSuggestionSelected: (suggestion) {
                print("$suggestion tapped");
                context.read<AuthProvider>().changeStateController(
                    id: suggestion.id.toString(),
                    value: suggestion.name.toString());
              },
              displayAllSuggestionWhenTap: true,
            ),
          ),
          const SizeBoxH(8),
          const CustomText(
            text: 'Select City *',
          ),
          const SizeBoxH(8),
          SizedBox(
            height: Responsive.height * 6,
            child: DropDownSearchField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: profileProvider.cityController,
                autofocus: false,
                style: context.textTheme.bodyLarge!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return profileProvider.cityListElement.where((items) {
                  return items.name.toString().toLowerCase().contains(
                        pattern.toLowerCase(),
                      );
                }).toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(title: Text(suggestion.name.toString()));
              },
              onSuggestionSelected: (suggestion) {
                print("$suggestion tapped");
                context.read<AuthProvider>().changeCityController(
                    id: suggestion.id.toString(),
                    value: suggestion.name.toString());
              },
              displayAllSuggestionWhenTap: true,
            ),
          ),
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
          const SizeBoxH(50),
          Center(
            child: ButtonWidgets(
              onPressed: () {
                authProvider.updateProfileFN(context: context);
              },
              buttonText: 'Update',
            ),
          )
        ],
      ));
    });
  }
}
