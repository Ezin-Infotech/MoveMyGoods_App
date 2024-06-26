import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
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
import '../../view model/settings_controller.dart';
import 'validation_mobile_number.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    return Consumer<AuthProvider>(builder: (context, profileProvider, _) {
      return CommonScaffold(
          isBackButton: true,
          children: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile'.tr,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    width: Responsive.width * 60,
                    height: Responsive.width * 30,
                    decoration: profileProvider.userProfilePic!.isNotEmpty
                        ? ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://storage.googleapis.com/common-mmg/${profileProvider.userProfilePic![0].path}"),
                              fit: BoxFit.contain,
                            ),
                            color: Colors.white,
                            shape: const CircleBorder(
                              side: BorderSide.none,
                            ),
                          )
                        : const ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/avathar1.png"),
                              fit: BoxFit.contain,
                            ),
                            color: Colors.white,
                            shape: CircleBorder(
                              side: BorderSide.none,
                            ),
                          ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 60, bottom: 3),
                      child: CircleAvatar(
                        radius: 12,
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: AppColors.black,
                                context: context,
                                builder: (builder) {
                                  return SizedBox(
                                    width: Responsive.width * 100,
                                    height: Responsive.height * 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            settingsProvider
                                                .pickImageFromGalleryOrCamera(
                                                    false, context);
                                            Navigator.of(context).pop();
                                          },
                                          child: SizedBox(
                                            height: Responsive.height * 20,
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset(
                                                      "assets/camera.png"),
                                                ),
                                                const SizeBoxH(10),
                                                const CustomText(
                                                  text: "Camera",
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            settingsProvider
                                                .pickImageFromGalleryOrCamera(
                                                    true, context);
                                            Navigator.of(context).pop();
                                          },
                                          child: SizedBox(
                                            height: Responsive.height * 20,
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset(
                                                      "assets/gallery.png"),
                                                ),
                                                const SizeBoxH(10),
                                                const CustomText(
                                                  text: "Gallery",
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.camera_alt_rounded)),
                      ),
                    ),
                  ),
                ]),
                BookingTextFieldWidgets(
                  labeText: "${'First Name'.tr}*",
                  hintText: 'john',
                  controller: profileProvider.firstNameController,
                  requiredText: 'Please enter first name'.tr,
                ),
                BookingTextFieldWidgets(
                  labeText: "${'Last Name'.tr}*",
                  hintText: 'joseph',
                  controller: profileProvider.lastNameController,
                  requiredText: 'Please enter last name'.tr,
                ),
                BookingTextFieldWidgets(
                  readOnly: true,
                  labeText: 'Mobile Number'.tr,
                  hintText: '00000000000',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      profileProvider.validPhoneNumberFn(false);
                      Get.to(const ValidationNumberSCreen());
                    },
                    child: Icon(
                      Icons.edit_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  controller: profileProvider.mobileNumberController,
                ),
                const SizeBoxH(18),
                CustomText(
                  text: 'Date Of Birth'.tr,
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
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff222222)),
                  hintTextColor: AppColors.darkGrey,
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: AppColors.primary,
                  ),
                  onTap: () async {
                    profileProvider.convertToTimeStampFn(context: context);
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
                              context
                                  .read<AuthProvider>()
                                  .setGenderId(value: 1);
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
                              context
                                  .read<AuthProvider>()
                                  .setGenderId(value: 2);
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
                  labeText: "${'Address Line 1'.tr} *",
                  hintText: 'Mysore Road',
                  controller: profileProvider.addressLineOneController,
                  requiredText: 'Please enter address'.tr,
                ),
                BookingTextFieldWidgets(
                  labeText: 'Address Line 2'.tr,
                  hintText: 'Near Canara Bank',
                  controller: profileProvider.addressLineTwoController,
                  requiredText: 'Please enter address'.tr,
                ),
                BookingTextFieldWidgets(
                  labeText: 'Landmark'.tr,
                  hintText: 'Near canara bank',
                  controller: profileProvider.landMarkController,
                ),
                const SizeBoxH(10),
                CustomText(
                  text: '${"Select State".tr} *',
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
                      context.read<AuthProvider>().changeStateController(
                          id: suggestion.id.toString(),
                          value: suggestion.name.toString());
                    },
                    displayAllSuggestionWhenTap: true,
                  ),
                ),
                const SizeBoxH(8),
                CustomText(
                  text: '${"Select City".tr} *',
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
                      context.read<AuthProvider>().changeCityController(
                          id: suggestion.id.toString(),
                          value: suggestion.name.toString());
                    },
                    displayAllSuggestionWhenTap: true,
                  ),
                ),
                BookingTextFieldWidgets(
                  keyboardType: TextInputType.number,
                  labeText: 'Pincode'.tr,
                  hintText: '0000001',
                  controller: profileProvider.picCodeController,
                ),
                BookingTextFieldWidgets(
                  keyboardType: TextInputType.phone,
                  labeText: 'Alternate Number'.tr,
                  hintText: '+919744213176',
                  controller: profileProvider.alternativeNumberController,
                ),
                const SizeBoxH(50),
                Center(
                  child: ButtonWidgets(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profileProvider.updateProfileFN(context: context);
                      }
                    },
                    buttonText: 'Update'.tr,
                  ),
                )
              ],
            ),
          ));
    });
  }
}
