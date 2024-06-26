import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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

class ValidationNumberSCreen extends StatefulWidget {
  const ValidationNumberSCreen({super.key});

  @override
  State<ValidationNumberSCreen> createState() => _ValidationNumberSCreenState();
}

class _ValidationNumberSCreenState extends State<ValidationNumberSCreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return CommonScaffold(
        isBackButton: true,
        children: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AuthProvider>(builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizeBoxH(
                  Responsive.height * 10,
                ),
                Text(
                  'Validation of Mobile Number'.tr,
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
                  hintText: 'Mobile Number'.tr,
                  controller: value.newPhoneNumberController,
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
                      'Verification needed'.tr,
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
                          if ((value.isPhoneNumber(
                              value.newPhoneNumberController.text))) {
                            authProvider.getPhoneNumberChangeOtpFn(
                                context: context);
                          } else {
                            errorBottomSheetDialogs(
                              isDismissible: false,
                              enableDrag: false,
                              context: context,
                              title: 'please enter valid phone number'.tr,
                              subtitle: '',
                            );
                          }
                        },
                        buttonText: 'Sent OTP'.tr,
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
                                  controller: value.newPhoneOtp1Controller),
                              textFieldOTP(
                                  first: false,
                                  last: false,
                                  controller: value.newPhoneOtp2Controller),
                              textFieldOTP(
                                  first: false,
                                  last: false,
                                  controller: value.newPhoneOtp3Controller),
                              textFieldOTP(
                                  first: false,
                                  last: true,
                                  controller: value.newPhoneOtp4Controller),
                            ],
                          ),
                          SizeBoxH(Responsive.height * 2.5),
                          ButtonWidgets(
                            onPressed: () {
                              authProvider.verifyPhoneNumberChangeOtpFn(
                                  context: context);
                            },
                            buttonText: 'Verify'.tr,
                            bgColor: AppColors.secondPrimary,
                          ),
                          SizeBoxH(Responsive.height * 2.5),
                          GestureDetector(
                            onTap: () => authProvider.getPhoneNumberChangeOtpFn(
                                context: context),
                            child: Text(
                              'Resend OTP'.tr,
                              style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.secondPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
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
