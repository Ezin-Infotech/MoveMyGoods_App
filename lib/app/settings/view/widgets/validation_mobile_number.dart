import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../utils/app style/responsive.dart';
import '../../../utils/common widgets/button.dart';
import '../../../utils/common widgets/dialogs.dart';
import '../../../utils/helpers.dart';
import '../../view model/settings_controller.dart';

class ValidationNumberSCreen extends StatefulWidget {
  const ValidationNumberSCreen({super.key});

  @override
  State<ValidationNumberSCreen> createState() => _ValidationNumberSCreenState();
}

class _ValidationNumberSCreenState extends State<ValidationNumberSCreen> {
  @override
  Widget build(BuildContext context) {
    final settingProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
        isBackButton: true,
        children: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SettingsProvider>(builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizeBoxH(
                  Responsive.height * 10,
                ),
                Text(
                  'Validation of Mobile Number',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                SizeBoxH(
                  Responsive.height * 2,
                ),
                CommonTextForm(
                  onChanged: (p0) {},
                  radius: 2,
                  fillColor: const Color(0xffe9ecef),
                  hintText: 'Mobile Number',
                  controller: settingProvider.phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                SizeBoxH(
                  Responsive.height * 0.5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: AppColors.secondPrimary,
                    ),
                    Text(
                      'Verification needed',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizeBoxH(
                  Responsive.height * 2,
                ),
                value.validPhoneNumber == false
                    ? ButtonWidgets(
                        onPressed: () {
                          if ((authProvider.isPhoneNumber(
                              value.phoneNumberController.text))) {
                            value.validPhoneNumberFn(true);
                          } else {
                            errorBottomSheetDialogs(
                              isDismissible: false,
                              enableDrag: false,
                              context: context,
                              title: 'please enter valid phonenumber',
                              subtitle: '',
                            );
                          }
                        },
                        buttonText: 'Sent OTP',
                        bgColor: AppColors.secondPrimary,
                      )
                    : const Text(''),
                value.validPhoneNumber == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              textFieldOTP(
                                  first: true,
                                  last: false,
                                  controller: value.otp1Controller),
                              textFieldOTP(
                                  first: false,
                                  last: false,
                                  controller: value.otp2Controller),
                              textFieldOTP(
                                  first: false,
                                  last: false,
                                  controller: value.otp3Controller),
                              textFieldOTP(
                                  first: false,
                                  last: true,
                                  controller: value.otp4Controller),
                            ],
                          ),
                          SizeBoxH(Responsive.height * 2.5),
                          ButtonWidgets(
                            onPressed: () {},
                            buttonText: 'Verify',
                            bgColor: AppColors.secondPrimary,
                          ),
                          SizeBoxH(Responsive.height * 2.5),
                          Text(
                            'Resend OTP',
                            style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.secondPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    : const Text('')
              ],
            );
          }),
        ));
  }

  Widget textFieldOTP(
      {required TextEditingController? controller, bool? first, last}) {
    return SizedBox(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              // FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
