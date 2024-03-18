// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/modal/city_list_model.dart';
import 'package:mmg/app/auth/modal/country_model.dart';
import 'package:mmg/app/auth/modal/profile_model.dart';
import 'package:mmg/app/auth/modal/state_list_model.dart';
import 'package:mmg/app/auth/modal/terms_n_condition_model.dart';
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  bool loginShowPassword = false;

  loginShowPasswordFn() {
    loginShowPassword = !loginShowPassword;
    notifyListeners();
  }

  TextEditingController forgetNewPasswordController = TextEditingController();
  TextEditingController forgetConfirmPasswordController =
      TextEditingController();
  bool forgetNewPassword = false;
  forgetNewPasswordFn() {
    forgetNewPassword = !forgetNewPassword;
    notifyListeners();
  }

  bool forgetConfirmPassword = false;
  forgetConfirmPasswordFn() {
    forgetConfirmPassword = !forgetConfirmPassword;
    notifyListeners();
  }

  setdateFn(String formattedDate) {
    dateController.text = formattedDate;
    notifyListeners();
  }

  bool isValid = false;

  void validate(String value) {
    // Password regex pattern
    final RegExp regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    isValid = regex.hasMatch(value);
    notifyListeners();
  }

  /* Login */
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
      );
    }
  }

  /* SIGN UP */
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController forgotPhoneNumberController = TextEditingController();

  getSignUpOTPFn({required BuildContext context}) async {
    if (signUpPhoneController.text.isEmpty) {
      failurtoast(title: 'Please fill phone number');
    } else {
      LoadingOverlay.of(context).show();
      try {
        final signInDataResponse = await services.postSignUpOtpService(
            email: signUpEmailController.text,
            phone: signUpPhoneController.text);
        print(signInDataResponse);
        LoadingOverlay.of(context).hide();
        Get.offNamed(AppRoutes.otpScreen, arguments: {
          'isFromForgotPassword': false,
        });
        // ignore: deprecated_member_use
      } on DioError catch (e) {
        LoadingOverlay.of(context).hide();
        errorBottomSheetDialogs(
          isDismissible: false,
          enableDrag: false,
          context: context,
          title: '${e.response!.data['message']}',
          subtitle: '',
        );
      }
    }
  }

  /* SIGN UP VERIFY OTP */
  verifySignUpOTPFn(
      {required BuildContext context, required bool isFromForgot}) async {
    if (otp1Controller.text.isNotEmpty &&
        otp2Controller.text.isNotEmpty &&
        otp3Controller.text.isNotEmpty &&
        otp4Controller.text.isNotEmpty) {
      LoadingOverlay.of(context).show();
      final String otp =
          '${otp1Controller.text}${otp2Controller.text}${otp3Controller.text}${otp4Controller.text}';
      try {
        await services.postVerifyOtpService(
            otp: otp, phone: signUpPhoneController.text);
        // signInData = signInDataResponse.data!;
        LoadingOverlay.of(context).hide();
        if (isFromForgot) {
          Get.toNamed(AppRoutes.forgetPasswordEnterPage);
        } else {
          Get.toNamed(AppRoutes.signUpProfileScreen);
          getTermsNConditionFn();
        }

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
        );
      }
    } else {
      failurtoast(title: 'Please fill all fields');
    }
  }

  /* SIGN UP VERIFY OTP */
  sendOtpToPhoneOnForgotPasswordFn({required BuildContext context}) async {
    if (signUpPhoneController.text.isNotEmpty) {
      LoadingOverlay.of(context).show();

      try {
        await services.forgotPasswordSendOtpService(
            phone: signUpPhoneController.text);
        LoadingOverlay.of(context).hide();
        Get.toNamed(AppRoutes.otpScreen, arguments: {
          'isFromForgotPassword': true,
        });
        // ignore: deprecated_member_use
      } on DioError catch (e) {
        LoadingOverlay.of(context).hide();
        errorBottomSheetDialogs(
          isDismissible: false,
          enableDrag: false,
          context: context,
          title: '${e.response!.data['message']}',
          subtitle: '',
        );
      }
    } else {
      failurtoast(title: 'Please Enter Your Phone Number');
    }
  }

  /* SIGN UP VERIFY OTP */
  changePasswordFn({
    required BuildContext context,
  }) async {
    if (forgetNewPasswordController.text.isEmpty &&
        forgetConfirmPasswordController.text.isEmpty) {
      failurtoast(title: 'Please fill all fields');
    }
    // else if(){

    // }

    else {
      LoadingOverlay.of(context).show();
      try {
        await services.updatePassWordService(
            confirmPassword: forgetConfirmPasswordController.text,
            phone: signUpPhoneController.text,
            password: forgetNewPasswordController.text);
        // signInData = signInDataResponse.data!;
        LoadingOverlay.of(context).hide();
        // if (isFromForgot) {
        //   Get.toNamed(AppRoutes.forgetPasswordEnterPage);
        // } else {
        //   Get.toNamed(AppRoutes.signUpProfileScreen);
        //   getTermsNConditionFn();
        // }

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
        );
      }
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

  List<StateListElement> stateListElement = [];
  getStateFn() async {
    try {
      final countryResponse =
          await services.getStateService(countryId: countryId);
      print('rrrrrrrrrrrrrrrr $countryResponse');
      stateListElement = countryResponse.data!.list!;
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

  List<CityListElement> cityListElement = [];
  getCityFn() async {
    try {
      final countryResponse = await services.getCityService(stateId: stateId);
      print('rrrrrrrrrrrrrrrr $countryResponse');
      cityListElement = countryResponse.data!.list!;
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

  List<TermsNConditionList> termsAndConditions = [];
  bool termsAndConditionsBoolean = false;
  getTermsNConditionFn() async {
    try {
      final countryResponse = await services.getTermsNConditionService();
      print('rrrrrrrrrrrrrrrr $countryResponse');
      termsAndConditions = countryResponse.data!.list!;
      termsAndConditionsBoolean = true;
      notifyListeners();
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

  GetUserProfileDetailsStatus getUserProfileDetailsStatus =
      GetUserProfileDetailsStatus.initial;
  ProfileDataModel profileDataModel = ProfileDataModel();
  getUserProfileDetailsFn() async {
    getUserProfileDetailsStatus = GetUserProfileDetailsStatus.loading;
    try {
      final countryResponse = await services.getProfileDetailService();
      profileDataModel = countryResponse;
      getUserProfileDetailsStatus = GetUserProfileDetailsStatus.loaded;
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      getUserProfileDetailsStatus = GetUserProfileDetailsStatus.error;
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

  int genderId = 1;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressLineOneController = TextEditingController();
  TextEditingController addressLineTwoController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController selectStateController = TextEditingController();
  TextEditingController picCodeController = TextEditingController();
  TextEditingController alternativeNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  setProfileValues({required BuildContext context}) {
    final data = context.read<AuthProvider>().profileDataModel;
    firstNameController.text = data.data!.firstName.toString();
    lastNameController.text = data.data!.lastName.toString();
    mobileNumberController.text = data.data!.mobileNumber.toString();
    addressLineOneController.text = data.data!.address![0].address1.toString();
    addressLineTwoController.text = data.data!.address![0].address2.toString();
    landMarkController.text = data.data!.address![0].landmark.toString();
    selectStateController.text = data.data!.address![0].stateName.toString();
    picCodeController.text = data.data!.address![0].pincode ?? '';
    alternativeNumberController.text = data.data!.alternativeNumber.toString();
    profileEmailController.text = data.data!.emailId.toString();
    genderId = int.parse(data.data!.genderId.toString());
  }

  clearProfileValues({required BuildContext context}) {
    firstNameController.clear();
    lastNameController.clear();
    mobileNumberController.clear();
    addressLineOneController.clear();
    addressLineTwoController.clear();
    landMarkController.clear();
    selectStateController.clear();
    picCodeController.clear();
    alternativeNumberController.clear();
    genderId = 3;
  }

  setGenderId({required int value}) {
    genderId = value;
    notifyListeners();
  }

  String countryId = '';
  String stateId = '';
  String cityId = '';

  createProfileFN({required BuildContext context}) async {
    LoadingOverlay.of(context).show();

    try {
      await services.postCreateProfileService(data: {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "mobileNumber": signUpPhoneController.text,
        "alternativeNumber": alternativeNumberController.text,
        "emailId": emailController.text,
        "roleId": 1,
        "genderId": genderId,
        "dob": "577477800000",
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text,
        "profileSource": "app",
        "address": [
          {
            "address1": addressLineOneController.text,
            "address2": addressLineTwoController.text,
            "landmark": landMarkController.text,
            "cityId": cityId.isEmpty ? 0 : int.parse(cityId),
            "stateId": stateId.isEmpty ? 0 : int.parse(stateId),
            "countryId": countryId.isEmpty ? 0 : int.parse(countryId),
            "pincode":
                picCodeController.text.isEmpty ? 0 : picCodeController.text,
            "type": "HOME"
          }
        ],
        "customer": {
          "customerTypeId": 1,
          "isTermsAndCondition": termsAndConditionsBoolean,
          "termsAndConditionsId": termsAndConditions[0].uuid ?? ''
        }
      });

      // signInData = signInDataResponse.data!;
      // AppPref.userToken = signInDataResponse["data"]["accessToken"];
      // AppPref.userProfileId = signInDataResponse["data"]["id"];
      clearProfileValues(context: context);
      Get.back();
      Get.back();
      Get.back();
      LoadingOverlay.of(context).hide();
      // clearLoginController();
      // isUserLoggedFn(isLogged: true);

      // getCountryFn(context: context);
      // Get.offNamed(AppRoutes.bookingScreen);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      LoadingOverlay.of(context).hide();
      errorBottomSheetDialogs(
        isDismissible: false,
        enableDrag: false,
        context: context,
        title: '${e.response!.data['message']}',
        subtitle: '',
      );
    }
  }

  changeCountryController({required String id, required String value}) {
    countryController.clear();
    countryController.text = value;
    countryId = id;
    notifyListeners();
    stateId = '';
    stateListElement = [];
    cityListElement = [];
    cityId = '';
    getStateFn();
    print(countryController.text);
  }

  changeStateController({required String id, required String value}) {
    stateController.clear();
    stateController.text = value;
    stateId = id;
    notifyListeners();
    cityListElement = [];
    cityId = '';
    getCityFn();
    print(stateController.text);
  }

  changeCityController({required String id, required String value}) {
    cityController.clear();
    cityController.text = value;
    cityId = id;
    notifyListeners();
    print(cityController.text);
  }
}
