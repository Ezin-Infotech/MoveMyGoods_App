// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/modal/country_model.dart';
import 'package:mmg/app/auth/services/auth_services.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/common%20widgets/dialogs.dart';
import 'package:mmg/app/utils/common%20widgets/loading_overlay.dart';
import 'package:mmg/app/utils/routes/route_names.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  TextEditingController signUpemailController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();

  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  AuthServices services = AuthServices();

  bool loginShowPassword = true;
  void loginShowPasswordFn() {
    loginShowPassword = !loginShowPassword;
    notifyListeners();
  }

  List<CountryList> countryList = [];
  /* API Functions */

  /* SIGN IN */
  onboardSignInFn({required BuildContext context}) async {
    LoadingOverlay.of(context).show();

    try {
      final signInDataResponse = await services.postSignInService(
          email: emailController.text, password: passWordController.text);
      // signInData = signInDataResponse.data!;
      AppPref.userToken = signInDataResponse["data"]["accessToken"];
      AppPref.userProfileId = signInDataResponse["data"]["id"];
      LoadingOverlay.of(context).hide();
      // clearLoginController();
      Get.offNamed(AppRoutes.bookingScreen);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      LoadingOverlay.of(context).hide();
      errorBottomSheetDialogs(
          isDismissible: false,
          enableDrag: false,
          context: context,
          title: '${e.response!.data['message']}',
          subtitle: '',
          isdarkmode: false);
    }
  }

  /* SIGN UP OTP REQUEST */
  getSignUpOTPFn({required BuildContext context}) async {
    LoadingOverlay.of(context).show();

    try {
      final signInDataResponse = await services.postSignUpOtpService(
          email: signUpemailController.text, phone: signUpPhoneController.text);
      // signInData = signInDataResponse.data!;
      print(signInDataResponse);
      LoadingOverlay.of(context).hide();
      // clearLoginController();
      Get.offNamed(AppRoutes.otpScreen);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      LoadingOverlay.of(context).hide();
      errorBottomSheetDialogs(
          isDismissible: false,
          enableDrag: false,
          context: context,
          title: '${e.response!.data['message']}',
          subtitle: '',
          isdarkmode: false);
    }
  }

  /* SIGN UP VERIFY OTP */
  verifySignUpOTPFn({required BuildContext context}) async {
    if (otp1Controller.text.isNotEmpty &&
        otp2Controller.text.isNotEmpty &&
        otp3Controller.text.isNotEmpty &&
        otp4Controller.text.isNotEmpty) {
      LoadingOverlay.of(context).show();
      final String otp =
          '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}';
      try {
        final signInDataResponse = await services.postVerifyOtpService(
            otp: otp, phone: signUpPhoneController.text);
        // signInData = signInDataResponse.data!;
        print(signInDataResponse);
        LoadingOverlay.of(context).hide();
        // clearLoginController();
        // Get.offNamed(AppRoutes.otpScreen);
        // ignore: deprecated_member_use
      } on DioError catch (e) {
        LoadingOverlay.of(context).hide();
        errorBottomSheetDialogs(
            isDismissible: false,
            enableDrag: false,
            context: context,
            title: '${e.response!.data['message']}',
            subtitle: '',
            isdarkmode: false);
      }
    } else {
      failurtoast(title: 'Please fill all fields');
    }
  }

  /* SIGN UP OTP REQUEST */
  getCountryFn({required BuildContext context}) async {
    try {
      final countryResponse = await services.getCountryService();
      print('rrrrrrrrrrrrrrrr $countryResponse');
      countryList = countryResponse.data!.list!;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      // errorBottomSheetDialogs(
      //     isDismissible: false,
      //     enableDrag: false,
      //     context: context,
      //     title: '${e.response!.data['message']}',
      //     subtitle: '',
      //     isdarkmode: false);
    }
  }
}
