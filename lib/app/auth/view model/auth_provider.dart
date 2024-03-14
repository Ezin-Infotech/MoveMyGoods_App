// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/modal/country_model.dart';
import 'package:mmg/app/auth/modal/user_profile_picture_model.dart';
import 'package:mmg/app/auth/services/auth_services.dart';
import 'package:mmg/app/home/view%20model/home_provider.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/common%20widgets/dialogs.dart';
import 'package:mmg/app/utils/common%20widgets/loading_overlay.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  AuthServices services = AuthServices();

  checkIsUserLoggedOnCacheFn() {
    if (AppPref.userToken == '') {
      isUserLogged = false;
      notifyListeners();
    } else {
      isUserLogged = true;
      notifyListeners();
    }
  }

  bool isUserLogged = false;
  isUserLoggedFn({required bool isLogged}) {
    isUserLogged = isLogged;
    notifyListeners();
  }

  /* Login */
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  bool loginShowPassword = false;

  loginShowPasswordFn() {
    loginShowPassword = !loginShowPassword;
    notifyListeners();
  }

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
      isUserLoggedFn(isLogged: true);
      context.read<HomeProvider>().getBookingCountFn();
      getCountryFn(context: context);
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

  /* SIGN UP */
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  getSignUpOTPFn({required BuildContext context}) async {
    LoadingOverlay.of(context).show();
    try {
      final signInDataResponse = await services.postSignUpOtpService(
          email: signUpEmailController.text, phone: signUpPhoneController.text);
      print(signInDataResponse);
      LoadingOverlay.of(context).hide();
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

  /* COUNTRY LIST */
  List<CountryList> countryList = [];

  getCountryFn({required BuildContext context}) async {
    try {
      final countryResponse = await services.getCountryService();
      print('rrrrrrrrrrrrrrrr $countryResponse');
      countryList = countryResponse.data!.list!;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message!);
      // errorBottomSheetDialogs(
      //     isDismissible: false,
      //     enableDrag: false,
      //     context: context,
      //     title: '${e.response!.data['message']}',
      //     subtitle: '',
      //     isdarkmode: false);
    }
  }

  List<Datum>? userProfilePic = [];
  GetUserProfilePicStatus getUserProfilePicStatus =
      GetUserProfilePicStatus.initial;
  getUserProfilePicFn() async {
    getUserProfilePicStatus = GetUserProfilePicStatus.loading;
    try {
      final countryResponse = await services.getUserProfilePicService();
      userProfilePic = countryResponse.data!;
      getUserProfilePicStatus = GetUserProfilePicStatus.loaded;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      getUserProfilePicStatus = GetUserProfilePicStatus.error;
      log(e.message!);
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
