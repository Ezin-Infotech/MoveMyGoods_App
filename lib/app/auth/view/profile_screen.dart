import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
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

import '../../utils/common widgets/dialogs.dart';

class SignUpProfileScreen extends StatelessWidget {
  SignUpProfileScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
        isBackButton: true,
        children: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingTextFieldWidgets(
                labeText: '${'First Name'.tr}*',
                hintText: 'john',
                controller: authProvider.firstNameController,
                requiredText: 'Please enter First Name',
              ),
              BookingTextFieldWidgets(
                labeText: 'Last Name'.tr,
                hintText: 'joseph',
                controller: authProvider.lastNameController,
                requiredText: 'Please enter Last Name',
              ),
              BookingTextFieldWidgets(
                labeText: "${'Mobile Number'.tr} *",
                hintText: '+919744213176',
                controller: authProvider.signUpPhoneController,
                requiredText: 'Please enter Mobile Number',
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
                          'Male'.tr,
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
                          'Female'.tr,
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
                labeText: '${'Date of Birth'.tr} *',
                hintText: '12-01-1998',
                controller: authProvider.dateController,
                requiredText: 'Please enter Date Of Birth',
                keyboardType: TextInputType.number,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2006),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2006),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat("yyyy-MM-dd").format(pickedDate);
                    authProvider.setdateFn(formattedDate);
                  } else {}
                },
              ),
              BookingTextFieldWidgets(
                labeText: '${'Email'.tr} *',
                hintText: 'john@example.com',
                controller: authProvider.profileEmailController,
                requiredText: 'Please enter Email',
              ),
              BookingTextFieldWidgets(
                labeText: "${'Address Line 1'.tr} *",
                hintText: 'Mysore Road',
                controller: authProvider.addressLineOneController,
                requiredText: 'Please enter Address Line 1',
              ),
              BookingTextFieldWidgets(
                labeText: 'Address Line 2'.tr,
                hintText: 'Near Canara Bank',
                controller: authProvider.addressLineTwoController,
                requiredText: 'Please enter Last Address Line 2',
              ),
              BookingTextFieldWidgets(
                labeText: 'Landmark'.tr,
                hintText: 'Near canara bank',
                controller: authProvider.landMarkController,
                requiredText: 'Please enter Landmark',
              ),
              // BookingTextFieldWidgets(
              //   labeText: 'Select Country *',
              //   hintText: 'Near canara bank',
              //   controller: authProvider.landMarkController,
              // ),
              CustomText(
                text: '${'Select Country'.tr} *',
              ),
              const SizeBoxH(8),
              SizedBox(
                height: Responsive.height * 6,
                child: DropDownSearchField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: authProvider.countryController,
                    autofocus: false,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return authProvider.countryList.where((items) {
                      return items.name.toString().toLowerCase().contains(
                            pattern.toLowerCase(),
                          );
                    }).toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(title: Text(suggestion.name.toString()));
                  },
                  onSuggestionSelected: (suggestion) {
                    context.read<AuthProvider>().changeCountryController(
                        id: suggestion.id.toString(),
                        value: suggestion.name.toString());
                  },
                  displayAllSuggestionWhenTap: true,
                ),
              ),

              CustomText(
                text: '${'Select State'.tr} *',
              ),
              const SizeBoxH(8),
              SizedBox(
                height: Responsive.height * 6,
                child: DropDownSearchField(
                  hideKeyboard: true,
                  hideOnEmpty: true,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: authProvider.stateController,
                    autofocus: false,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return authProvider.stateListElement.where((items) {
                      return items.name.toString().toLowerCase().contains(
                            pattern.toLowerCase(),
                          );
                    }).toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(title: Text(suggestion.name.toString()));
                  },
                  onSuggestionSelected: (suggestion) {
                    context.read<AuthProvider>().changeStateController(
                        id: suggestion.id.toString(),
                        value: suggestion.name.toString());
                  },
                  displayAllSuggestionWhenTap: true,
                ),
              ),
              CustomText(
                text: '${'Select City'.tr} *',
              ),
              const SizeBoxH(8),
              SizedBox(
                height: Responsive.height * 6,
                child: DropDownSearchField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: authProvider.cityController,
                    autofocus: false,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return authProvider.cityListElement.where((items) {
                      return items.name.toString().toLowerCase().contains(
                            pattern.toLowerCase(),
                          );
                    }).toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(title: Text(suggestion.name.toString()));
                  },
                  onSuggestionSelected: (suggestion) {
                    context.read<AuthProvider>().changeCityController(
                        id: suggestion.id.toString(),
                        value: suggestion.name.toString());
                  },
                  displayAllSuggestionWhenTap: true,
                ),
              ),
              BookingTextFieldWidgets(
                labeText: 'Alternate Number'.tr,
                hintText: '+919744213176',
                controller: authProvider.alternativeNumberController,
                requiredText: 'Please enter Alternate Number',
                keyboardType: TextInputType.phone,
              ),
              BookingTextFieldWidgets(
                labeText: "${'Password'.tr} *",
                hintText: 'Password',
                controller: authProvider.passwordController,
                requiredText: 'Please enter Password',
                onChanged: (p0) => log(p0),
              ),
              BookingTextFieldWidgets(
                labeText: "${'Confirm Password'.tr} *",
                hintText: 'Confirm Password',
                controller: authProvider.confirmPasswordController,
                requiredText: 'Please enter Confirm Password',
                onChanged: (value) {
                  Provider.of<AuthProvider>(context, listen: false)
                      .validate(value);
                },
              ),
              const SizeBoxH(20),
              Center(
                child: ButtonWidgets(
                  buttonText: 'Submit'.tr,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (authProvider.confirmPasswordController.text ==
                          authProvider.passwordController.text) {
                        context
                            .read<AuthProvider>()
                            .createProfileFN(context: context);
                      } else {
                        errorBottomSheetDialogs(
                          isDismissible: false,
                          enableDrag: false,
                          context: context,
                          title: 'Please check password and confirm password',
                          subtitle: '',
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
