import 'dart:developer';

// import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/custom_text.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class SignUpProfileScreen extends StatelessWidget {
  SignUpProfileScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
        children: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingTextFieldWidgets(
            labeText: 'First Name *',
            hintText: 'john',
            controller: authProvider.firstNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter First Name';
              } else {
                return null;
              }
            },
          ),
          BookingTextFieldWidgets(
            labeText: 'Last Name',
            hintText: 'joseph',
            controller: authProvider.lastNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Last Name';
              } else {
                return null;
              }
            },
          ),
          BookingTextFieldWidgets(
            labeText: 'Mobile Number *',
            hintText: '+919744213176',
            controller: authProvider.signUpPhoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Mobile Number';
              } else {
                return null;
              }
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
            labeText: 'Date of Birth *',
            hintText: '12-01-1998',
            controller: authProvider.dateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Date Of Birth';
              } else {
                return null;
              }
            },
          ),
          BookingTextFieldWidgets(
            labeText: 'Email *',
            hintText: 'john@example.com',
            controller: authProvider.profileEmailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Email';
              } else {
                return null;
              }
            },
          ),
          BookingTextFieldWidgets(
            labeText: 'Address Line 1 *',
            hintText: 'Mysore Road',
            controller: authProvider.addressLineOneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Address Line 1';
              } else {
                return null;
              }
            },
          ),
          BookingTextFieldWidgets(
            labeText: 'Address Line 2',
            hintText: 'Near Canara Bank',
            controller: authProvider.addressLineTwoController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Last Address Line 2';
              } else {
                return null;
              }
            },
          ),
          BookingTextFieldWidgets(
            labeText: 'Landmark',
            hintText: 'Near canara bank',
            controller: authProvider.landMarkController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Landmark';
              } else {
                return null;
              }
            },
          ),
          // BookingTextFieldWidgets(
          //   labeText: 'Select Country *',
          //   hintText: 'Near canara bank',
          //   controller: authProvider.landMarkController,
          // ),
          const CustomText(
            text: 'Select Country *',
          ),
          const SizeBoxH(8),
          // SizedBox(
          //   height: Responsive.height * 6,
          //   child: DropDownSearchField(
          //     textFieldConfiguration: TextFieldConfiguration(
          //       controller: authProvider.countryController,
          //       autofocus: false,
          //       style: context.textTheme.bodyLarge!
          //           .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //     suggestionsCallback: (pattern) async {
          //       return authProvider.countryList.where((items) {
          //         return items.name.toString().toLowerCase().contains(
          //               pattern.toLowerCase(),
          //             );
          //       }).toList();
          //     },
          //     itemBuilder: (context, suggestion) {
          //       return ListTile(title: Text(suggestion.name.toString()));
          //     },
          //     onSuggestionSelected: (suggestion) {
          //       print("$suggestion tapped");
          //       context.read<AuthProvider>().changeCountryController(
          //           id: suggestion.id.toString(),
          //           value: suggestion.name.toString());
          //     },
          //     displayAllSuggestionWhenTap: true,
          //   ),
          // ),

          const CustomText(
            text: 'Select State *',
          ),
          const SizeBoxH(8),
          // SizedBox(
          //   height: Responsive.height * 6,
          //   child: DropDownSearchField(
          //     hideKeyboard: true,
          //     hideOnEmpty: true,
          //     textFieldConfiguration: TextFieldConfiguration(
          //       controller: authProvider.stateController,
          //       autofocus: false,
          //       style: context.textTheme.bodyLarge!
          //           .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //     suggestionsCallback: (pattern) async {
          //       return authProvider.stateListElement.where((items) {
          //         return items.name.toString().toLowerCase().contains(
          //               pattern.toLowerCase(),
          //             );
          //       }).toList();
          //     },
          //     itemBuilder: (context, suggestion) {
          //       return ListTile(title: Text(suggestion.name.toString()));
          //     },
          //     onSuggestionSelected: (suggestion) {
          //       print("$suggestion tapped");
          //       context.read<AuthProvider>().changeStateController(
          //           id: suggestion.id.toString(),
          //           value: suggestion.name.toString());
          //     },
          //     displayAllSuggestionWhenTap: true,
          //   ),
          // ),
          const CustomText(
            text: 'Select City *',
          ),
          const SizeBoxH(8),
          // SizedBox(
          //   height: Responsive.height * 6,
          //   child: DropDownSearchField(
          //     textFieldConfiguration: TextFieldConfiguration(
          //       controller: authProvider.cityController,
          //       autofocus: false,
          //       style: context.textTheme.bodyLarge!
          //           .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          //       decoration: const InputDecoration(
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //     suggestionsCallback: (pattern) async {
          //       return authProvider.cityListElement.where((items) {
          //         return items.name.toString().toLowerCase().contains(
          //               pattern.toLowerCase(),
          //             );
          //       }).toList();
          //     },
          //     itemBuilder: (context, suggestion) {
          //       return ListTile(title: Text(suggestion.name.toString()));
          //     },
          //     onSuggestionSelected: (suggestion) {
          //       print("$suggestion tapped");
          //       context.read<AuthProvider>().changeCityController(
          //           id: suggestion.id.toString(),
          //           value: suggestion.name.toString());
          //     },
          //     displayAllSuggestionWhenTap: true,
          //   ),
          // ),
          BookingTextFieldWidgets(
            labeText: 'Alternate Number',
            hintText: '+919744213176',
            controller: authProvider.alternativeNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Alternate Number';
              } else {
                return null;
              }
            },
          ),
          BookingTextFieldWidgets(
            labeText: 'Password *',
            hintText: 'Password',
            controller: authProvider.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Password';
              } else {
                return null;
              }
            },
            onChanged: (p0) => log(p0),
          ),
          BookingTextFieldWidgets(
            labeText: 'Confirm Password *',
            hintText: 'Confirm Password',
            controller: authProvider.confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Confirm Password';
              } else {
                return null;
              }
            },
          ),
          const SizeBoxH(20),
          Center(
            child: ButtonWidgets(
              buttonText: 'Submit',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<AuthProvider>()
                      .createProfileFN(context: context);
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
