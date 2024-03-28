import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                SizeBoxH(Responsive.height * 10),
                Image.asset(
                  AppImages.blakLogo,
                ),
                SizeBoxH(Responsive.height * 2.5),
                Text(
                  'Verification'.tr,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizeBoxH(Responsive.height * 1),
                Text(
                  "Enter your OTP code".tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizeBoxH(Responsive.height * 10),
                Container(
                  // padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Consumer<AuthProvider>(builder: (context, value, _) {
                    return Column(
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
                          buttonText: 'Verify'.tr,
                          width: double.infinity,
                          height: 50,
                          onPressed: () {
                            context.read<AuthProvider>().verifySignUpOTPFn(
                                context: context,
                                isFromForgot:
                                    context.args['isFromForgotPassword'] ??
                                        false);

                            // context.push(const LoginScreen());
                          },
                        ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     onPressed: () {},
                        //     style: ButtonStyle(
                        //       foregroundColor:
                        //           MaterialStateProperty.all<Color>(Colors.white),
                        //       backgroundColor: MaterialStateProperty.all<Color>(
                        //           AppColors.primary),
                        //       shape:
                        //           MaterialStateProperty.all<RoundedRectangleBorder>(
                        //         RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(24.0),
                        //         ),
                        //       ),
                        //     ),
                        //     child: const Padding(
                        //       padding: EdgeInsets.all(14.0),
                        //       child: Text(
                        //         'Verify',
                        //         style: TextStyle(fontSize: 16),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    );
                  }),
                ),
                SizeBoxH(Responsive.height * 2),
                Text(
                  "${"Didn't you receive any code?".tr} ",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizeBoxH(Responsive.height * 2),
                Text(
                  "Resend New Code".tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              FocusScope.of(context).previousFocus();
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
